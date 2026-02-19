import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart';
import '../models/user_model.dart';
import 'local_storage_service.dart';

class AuthService {
  final LocalStorageService _localStorage = LocalStorageService();
  final Uuid _uuid = const Uuid();

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Hash password using SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Validate email format
  bool _isValidEmail(String email) {
    return isEmail(email);
  }

  // Validate password strength
  bool _isValidPassword(String password) {
    // At least 6 characters
    return password.length >= 6;
  }

  // Validate username
  bool _isValidUsername(String username) {
    // 3-20 characters, alphanumeric and underscores only
    if (username.length < 3 || username.length > 20) return false;
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    return usernameRegex.hasMatch(username);
  }

  // Validate full name
  bool _isValidFullName(String fullName) {
    // At least 5 characters and contains a space
    if (fullName.length < 5) return false;
    return fullName.trim().contains(' ');
  }

  // ===== OFFLINE REGISTRATION =====

  Future<AuthResult> registerOffline({
    required String email,
    required String username,
    required String fullName,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (!_isValidEmail(email)) {
        return AuthResult.error('Geçersiz email adresi');
      }

      if (!_isValidFullName(fullName)) {
        return AuthResult.error(
            'Ad Soyad en az 5 karakter olmalı ve ad ile soyad arasında boşluk olmalıdır');
      }

      if (!_isValidUsername(username)) {
        return AuthResult.error(
            'Kullanıcı adı 3-20 karakter olmalı ve sadece harf, rakam ve _ içerebilir');
      }

      if (!_isValidPassword(password)) {
        return AuthResult.error('Şifre en az 6 karakter olmalıdır');
      }

      // Check if user already exists locally
      if (await _localStorage.hasUser()) {
        return AuthResult.error('Bu cihazda zaten bir kullanıcı kayıtlı');
      }

      // Generate temporary UUID (will be replaced with Firebase UID on sync)
      final tempUid = 'temp_${_uuid.v4()}';

      // Hash password
      final passwordHash = _hashPassword(password);

      // Create user model
      final now = DateTime.now();
      final user = UserModel(
        uid: tempUid,
        email: email.toLowerCase().trim(),
        username: username.trim(),
        fullName: fullName.trim(),
        createdAt: now,
        lastActive: now,
        isSynced: false,
      );

      // Save user and password hash
      await _localStorage.saveUser(user);
      await _localStorage.savePasswordHash(passwordHash);

      // Add to sync queue
      await _localStorage.addToSyncQueue({
        'type': 'user_create',
        'uid': tempUid,
        'email': user.email,
        'username': user.username,
        'fullName': user.fullName,
        'passwordHash': passwordHash,
        'createdAt': now.millisecondsSinceEpoch,
      });

      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.error('Kayıt oluşturulamadı: $e');
    }
  }

  // ===== LOGIN =====

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      // Get stored user
      final user = await _localStorage.getUser();
      if (user == null) {
        return AuthResult.error('Kullanıcı bulunamadı');
      }

      // Verify email
      if (user.email.toLowerCase() != email.toLowerCase().trim()) {
        return AuthResult.error('Email veya şifre hatalı');
      }

      // Verify password
      final storedHash = await _localStorage.getPasswordHash();
      final inputHash = _hashPassword(password);

      if (storedHash != inputHash) {
        return AuthResult.error('Email veya şifre hatalı');
      }

      // Update last active
      final updatedUser = user.copyWith(lastActive: DateTime.now());
      await _localStorage.saveUser(updatedUser);

      return AuthResult.success(updatedUser);
    } catch (e) {
      return AuthResult.error('Giriş yapılamadı: $e');
    }
  }

  // ===== LOGOUT =====

  Future<void> logout() async {
    await _localStorage.deleteUser();
  }

  // ===== GET CURRENT USER =====

  Future<UserModel?> getCurrentUser() async {
    return await _localStorage.getUser();
  }

  // ===== CHECK AUTH STATUS =====

  Future<bool> isLoggedIn() async {
    return await _localStorage.hasUser();
  }

  // ===== UPDATE USER =====

  Future<AuthResult> updateUser(UserModel user) async {
    try {
      await _localStorage.saveUser(user);

      // Add to sync queue if synced user
      if (user.isSynced) {
        await _localStorage.addToSyncQueue({
          'type': 'user_update',
          'uid': user.uid,
          'data': user.toJson(),
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        });
      }

      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.error('Kullanıcı güncellenemedi: $e');
    }
  }

  // ===== PASSWORD RESET (Offline) =====

  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Verify current password
      final storedHash = await _localStorage.getPasswordHash();
      final currentHash = _hashPassword(currentPassword);

      if (storedHash != currentHash) {
        return AuthResult.error('Mevcut şifre hatalı');
      }

      // Validate new password
      if (!_isValidPassword(newPassword)) {
        return AuthResult.error('Yeni şifre en az 6 karakter olmalıdır');
      }

      // Save new password hash
      final newHash = _hashPassword(newPassword);
      await _localStorage.savePasswordHash(newHash);

      // Add to sync queue
      final user = await getCurrentUser();
      if (user != null && user.isSynced) {
        await _localStorage.addToSyncQueue({
          'type': 'password_change',
          'uid': user.uid,
          'newPasswordHash': newHash,
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        });
      }

      return AuthResult.success(null);
    } catch (e) {
      return AuthResult.error('Şifre değiştirilemedi: $e');
    }
  }
}

// Auth result wrapper
class AuthResult {
  final bool success;
  final UserModel? user;
  final String? error;

  AuthResult._({
    required this.success,
    this.user,
    this.error,
  });

  factory AuthResult.success(UserModel? user) {
    return AuthResult._(success: true, user: user);
  }

  factory AuthResult.error(String message) {
    return AuthResult._(success: false, error: message);
  }
}
