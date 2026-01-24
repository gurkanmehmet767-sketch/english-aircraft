import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LocalStorageService {
  static const String _keyUser = 'current_user';
  static const String _keySyncQueue = 'sync_queue';
  static const String _keyFriends = 'cached_friends';
  static const String _keyPasswordHash = 'password_hash';

  // Singleton pattern
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  SharedPreferences? _prefs;

  // Initialize
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Ensure initialized
  Future<SharedPreferences> get prefs async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  // ===== USER OPERATIONS =====

  // Save current user
  Future<void> saveUser(UserModel user) async {
    final p = await prefs;
    final userJson = json.encode(user.toJson());
    await p.setString(_keyUser, userJson);
  }

  // Get current user
  Future<UserModel?> getUser() async {
    final p = await prefs;
    final userJson = p.getString(_keyUser);
    if (userJson == null) return null;

    try {
      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  // Delete user (logout)
  Future<void> deleteUser() async {
    final p = await prefs;
    await p.remove(_keyUser);
    await p.remove(_keyPasswordHash);
  }

  // Check if user exists
  Future<bool> hasUser() async {
    final p = await prefs;
    return p.containsKey(_keyUser);
  }

  // ===== PASSWORD OPERATIONS =====

  // Save password hash (for offline login)
  Future<void> savePasswordHash(String hash) async {
    final p = await prefs;
    await p.setString(_keyPasswordHash, hash);
  }

  // Get password hash
  Future<String?> getPasswordHash() async {
    final p = await prefs;
    return p.getString(_keyPasswordHash);
  }

  // ===== SYNC QUEUE OPERATIONS =====

  // Save sync queue
  Future<void> saveSyncQueue(List<Map<String, dynamic>> queue) async {
    final p = await prefs;
    final queueJson = json.encode(queue);
    await p.setString(_keySyncQueue, queueJson);
  }

  // Get sync queue
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    final p = await prefs;
    final queueJson = p.getString(_keySyncQueue);
    if (queueJson == null) return [];

    try {
      final queueList = json.decode(queueJson) as List<dynamic>;
      return queueList.map((e) => e as Map<String, dynamic>).toList();
    } catch (e) {
      return [];
    }
  }

  // Add to sync queue
  Future<void> addToSyncQueue(Map<String, dynamic> item) async {
    final queue = await getSyncQueue();
    queue.add(item);
    await saveSyncQueue(queue);
  }

  // Clear sync queue
  Future<void> clearSyncQueue() async {
    final p = await prefs;
    await p.remove(_keySyncQueue);
  }

  // ===== FRIENDS CACHE OPERATIONS =====

  // Save friends cache
  Future<void> saveFriends(List<UserModel> friends) async {
    final p = await prefs;
    final friendsJson = json.encode(friends.map((f) => f.toJson()).toList());
    await p.setString(_keyFriends, friendsJson);
  }

  // Get friends cache
  Future<List<UserModel>> getFriends() async {
    final p = await prefs;
    final friendsJson = p.getString(_keyFriends);
    if (friendsJson == null) return [];

    try {
      final friendsList = json.decode(friendsJson) as List<dynamic>;
      return friendsList
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  // Clear friends cache
  Future<void> clearFriendsCache() async {
    final p = await prefs;
    await p.remove(_keyFriends);
  }

  // ===== UTILITY METHODS =====

  // Clear all data
  Future<void> clearAll() async {
    final p = await prefs;
    await p.clear();
  }

  // Check if email exists (for registration validation)
  Future<bool> emailExists(String email) async {
    final user = await getUser();
    if (user == null) return false;
    return user.email.toLowerCase() == email.toLowerCase();
  }

  // Check if username exists (for registration validation)
  Future<bool> usernameExists(String username) async {
    final user = await getUser();
    if (user == null) return false;
    return user.username.toLowerCase() == username.toLowerCase();
  }
}
