import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton pattern
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  // ===== USER OPERATIONS =====

  // Create user in Firestore
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  // Get user by UID
  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromJson(doc.data()!);
  }

  // Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    final query = await _firestore
        .collection('users')
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return UserModel.fromJson(query.docs.first.data());
  }

  // Check if username exists
  Future<bool> usernameExists(String username) async {
    final query = await _firestore
        .collection('users')
        .where('username', isEqualTo: username.toLowerCase())
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }

  // Update user
  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toJson());
  }

  // Update user progress
  Future<void> updateUserProgress(
      String uid, Map<String, dynamic> progress) async {
    await _firestore.collection('users').doc(uid).update(progress);
  }

  // ===== FRIENDS OPERATIONS =====

  // Send friend request
  Future<void> sendFriendRequest(String fromUid, String toUid,
      String fromUsername, String toUsername) async {
    final requestId = '${fromUid}_$toUid';
    final request = FriendRequest(
      id: requestId,
      fromUserId: fromUid,
      fromUsername: fromUsername,
      toUserId: toUid,
      toUsername: toUsername,
      status: 'pending',
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('friendRequests')
        .doc(requestId)
        .set(request.toJson());
  }

  // Accept friend request
  Future<void> acceptFriendRequest(String requestId) async {
    final requestDoc =
        await _firestore.collection('friendRequests').doc(requestId).get();
    if (!requestDoc.exists) return;

    final request = FriendRequest.fromJson(requestDoc.data()!);

    // Update request status
    await _firestore
        .collection('friendRequests')
        .doc(requestId)
        .update({'status': 'accepted'});

    // Add to each user's friends list
    await _firestore.collection('users').doc(request.fromUserId).update({
      'friendIds': FieldValue.arrayUnion([request.toUserId])
    });

    await _firestore.collection('users').doc(request.toUserId).update({
      'friendIds': FieldValue.arrayUnion([request.fromUserId])
    });
  }

  // Reject friend request
  Future<void> rejectFriendRequest(String requestId) async {
    await _firestore
        .collection('friendRequests')
        .doc(requestId)
        .update({'status': 'rejected'});
  }

  // Get friend requests (received)
  Future<List<FriendRequest>> getFriendRequests(String uid) async {
    final query = await _firestore
        .collection('friendRequests')
        .where('toUserId', isEqualTo: uid)
        .where('status', isEqualTo: 'pending')
        .get();

    return query.docs.map((doc) => FriendRequest.fromJson(doc.data())).toList();
  }

  // Get friends list
  Future<List<UserModel>> getFriends(String uid) async {
    final user = await getUser(uid);
    if (user == null || user.friendIds.isEmpty) return [];

    final friendsQuery = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: user.friendIds)
        .get();

    return friendsQuery.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  // Search users by username
  Future<List<UserModel>> searchUsersByUsername(String query) async {
    if (query.isEmpty) return [];

    final usersQuery = await _firestore
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('username', isLessThan: '${query.toLowerCase()}z')
        .limit(20)
        .get();

    return usersQuery.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  // Remove friend
  Future<void> removeFriend(String uid, String friendUid) async {
    await _firestore.collection('users').doc(uid).update({
      'friendIds': FieldValue.arrayRemove([friendUid])
    });

    await _firestore.collection('users').doc(friendUid).update({
      'friendIds': FieldValue.arrayRemove([uid])
    });
  }

  // ===== LEADERBOARD OPERATIONS =====

  // Get global leaderboard
  Future<List<LeaderboardEntry>> getGlobalLeaderboard(String league,
      {int limit = 50}) async {
    final query = await _firestore
        .collection('leaderboards')
        .doc('global')
        .collection(league.toLowerCase())
        .orderBy('xp', descending: true)
        .limit(limit)
        .get();

    return query.docs.asMap().entries.map((entry) {
      final rank = entry.key + 1;
      return LeaderboardEntry.fromJson(entry.value.data(), rank);
    }).toList();
  }

  // Get friends leaderboard
  Future<List<LeaderboardEntry>> getFriendsLeaderboard(String uid,
      {int limit = 50}) async {
    final friends = await getFriends(uid);
    if (friends.isEmpty) return [];

    // Get current user
    final currentUser = await getUser(uid);
    if (currentUser != null) {
      friends.add(currentUser);
    }

    // Sort by XP
    friends.sort((a, b) => b.xp.compareTo(a.xp));

    // Convert to leaderboard entries
    return friends
        .asMap()
        .entries
        .map((entry) {
          final rank = entry.key + 1;
          final user = entry.value;
          return LeaderboardEntry(
            uid: user.uid,
            username: user.username,
            photoURL: user.photoURL,
            xp: user.xp,
            league: user.league,
            rank: rank,
            updatedAt: user.lastActive,
          );
        })
        .take(limit)
        .toList();
  }

  // Update leaderboard
  Future<void> updateLeaderboard(
      String uid, String username, int xp, String league) async {
    final data = {
      'uid': uid,
      'username': username,
      'xp': xp,
      'league': league,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('leaderboards')
        .doc('global')
        .collection(league.toLowerCase())
        .doc(uid)
        .set(data, SetOptions(merge: true));
  }

  // ===== STATISTICS =====

  // Get user rank in global leaderboard
  Future<int> getUserGlobalRank(String uid, String league) async {
    final user = await getUser(uid);
    if (user == null) return 0;

    final higherRanked = await _firestore
        .collection('leaderboards')
        .doc('global')
        .collection(league.toLowerCase())
        .where('xp', isGreaterThan: user.xp)
        .count()
        .get();

    return higherRanked.count! + 1;
  }
}
