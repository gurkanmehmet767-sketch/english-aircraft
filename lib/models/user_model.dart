class UserModel {
  final String uid;
  final String email;
  final String username;
  final String? fullName;
  final String? photoURL;

  // Game Stats
  final int xp;
  final int level;
  final String league;
  final int streak;
  final int lives;

  // Progress
  final List<String> completedLessons;
  final Map<String, int> masteryLevels;
  final Map<String, dynamic> wordStats;

  // Friends
  final List<String> friendIds;
  final List<String> pendingRequestIds;

  // Sync
  final bool isSynced;
  final DateTime createdAt;
  final DateTime lastActive;
  final DateTime? lastSyncAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    this.fullName,
    this.photoURL,
    this.xp = 0,
    this.level = 1,
    this.league = 'Alpha',
    this.streak = 0,
    this.lives = 5,
    this.completedLessons = const [],
    this.masteryLevels = const {},
    this.wordStats = const {},
    this.friendIds = const [],
    this.pendingRequestIds = const [],
    this.isSynced = false,
    required this.createdAt,
    required this.lastActive,
    this.lastSyncAt,
  });

  // Create from JSON (for local storage and Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String?,
      photoURL: json['photoURL'] as String?,
      xp: json['xp'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      league: json['league'] as String? ?? 'Alpha',
      streak: json['streak'] as int? ?? 0,
      lives: json['lives'] as int? ?? 5,
      completedLessons: (json['completedLessons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      masteryLevels: (json['masteryLevels'] as Map<String, dynamic>?)
              ?.map((key, value) => MapEntry(key, value as int)) ??
          {},
      wordStats: json['wordStats'] as Map<String, dynamic>? ?? {},
      friendIds: (json['friendIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      pendingRequestIds: (json['pendingRequestIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isSynced: json['isSynced'] as bool? ?? false,
      createdAt: json['createdAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : DateTime.parse(json['createdAt'] as String),
      lastActive: json['lastActive'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['lastActive'] as int)
          : DateTime.parse(json['lastActive'] as String),
      lastSyncAt: json['lastSyncAt'] != null
          ? (json['lastSyncAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['lastSyncAt'] as int)
              : DateTime.parse(json['lastSyncAt'] as String))
          : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'fullName': fullName,
      'photoURL': photoURL,
      'xp': xp,
      'level': level,
      'league': league,
      'streak': streak,
      'lives': lives,
      'completedLessons': completedLessons,
      'masteryLevels': masteryLevels,
      'wordStats': wordStats,
      'friendIds': friendIds,
      'pendingRequestIds': pendingRequestIds,
      'isSynced': isSynced,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastActive': lastActive.millisecondsSinceEpoch,
      'lastSyncAt': lastSyncAt?.millisecondsSinceEpoch,
    };
  }

  // CopyWith for immutability
  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? fullName,
    String? photoURL,
    int? xp,
    int? level,
    String? league,
    int? streak,
    int? lives,
    List<String>? completedLessons,
    Map<String, int>? masteryLevels,
    Map<String, dynamic>? wordStats,
    List<String>? friendIds,
    List<String>? pendingRequestIds,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? lastActive,
    DateTime? lastSyncAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      photoURL: photoURL ?? this.photoURL,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      league: league ?? this.league,
      streak: streak ?? this.streak,
      lives: lives ?? this.lives,
      completedLessons: completedLessons ?? this.completedLessons,
      masteryLevels: masteryLevels ?? this.masteryLevels,
      wordStats: wordStats ?? this.wordStats,
      friendIds: friendIds ?? this.friendIds,
      pendingRequestIds: pendingRequestIds ?? this.pendingRequestIds,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      lastActive: lastActive ?? this.lastActive,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
    );
  }
}

class FriendRequest {
  final String id;
  final String fromUserId;
  final String fromUsername;
  final String toUserId;
  final String toUsername;
  final String status; // 'pending', 'accepted', 'rejected'
  final DateTime createdAt;

  FriendRequest({
    required this.id,
    required this.fromUserId,
    required this.fromUsername,
    required this.toUserId,
    required this.toUsername,
    required this.status,
    required this.createdAt,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      fromUsername: json['fromUsername'] as String,
      toUserId: json['toUserId'] as String,
      toUsername: json['toUsername'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromUserId': fromUserId,
      'fromUsername': fromUsername,
      'toUserId': toUserId,
      'toUsername': toUsername,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  FriendRequest copyWith({
    String? id,
    String? fromUserId,
    String? fromUsername,
    String? toUserId,
    String? toUsername,
    String? status,
    DateTime? createdAt,
  }) {
    return FriendRequest(
      id: id ?? this.id,
      fromUserId: fromUserId ?? this.fromUserId,
      fromUsername: fromUsername ?? this.fromUsername,
      toUserId: toUserId ?? this.toUserId,
      toUsername: toUsername ?? this.toUsername,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LeaderboardEntry {
  final String uid;
  final String username;
  final String? photoURL;
  final int xp;
  final String league;
  final int rank;
  final DateTime updatedAt;

  LeaderboardEntry({
    required this.uid,
    required this.username,
    this.photoURL,
    required this.xp,
    required this.league,
    required this.rank,
    required this.updatedAt,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json, int rank) {
    return LeaderboardEntry(
      uid: json['uid'] as String,
      username: json['username'] as String,
      photoURL: json['photoURL'] as String?,
      xp: json['xp'] as int,
      league: json['league'] as String,
      rank: rank,
      updatedAt: json['updatedAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] as int)
          : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'photoURL': photoURL,
      'xp': xp,
      'league': league,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }
}
