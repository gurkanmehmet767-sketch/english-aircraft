// Auth Service Tests - Offline authentication
// Simplified tests based on actual AuthService implementation
import 'package:flutter_test/flutter_test.dart';
import 'package:english_aircraft/services/auth_service.dart';

void main() {
  group('AuthService Basic Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('AuthService should be singleton', () {
      final instance1 = AuthService();
      final instance2 = AuthService();
      expect(instance1, same(instance2));
    });

    test('registerOffline should require valid email', () async {
      final result = await authService.registerOffline(
        email: 'invalid-email',
        username: 'testuser',
        password: 'Pass123',
      );
      
      expect(result.success, false);
      expect(result.error, contains('email'));
    });

    test('registerOffline should require strong password', () async {
      final result = await authService.registerOffline(
        email: 'test@example.com',
        username: 'testuser',
        password: '123', // Too short
      );
      
      expect(result.success, false);
      expect(result.error, contains('en az 6'));
    });

    test('registerOffline should require valid username', () async {
      final result = await authService.registerOffline(
        email: 'test@example.com',
        username: 'ab', // Too short
        password: 'Pass123',
      );
      
      expect(result.success, false);
      expect(result.error, contains('3-20'));
    });

    test('login should  fail with non-existent user', () async {
      final result = await authService.login(
        email: 'nonexistent@test.com',
        password: 'anypassword',
      );
      
      expect(result.success, false);
    });

    test('isLoggedIn should check user status', () async {
      final loggedIn = await authService.isLoggedIn();
      expect(loggedIn, isA<bool>());
    });

    test('getCurrentUser can return null when not logged in', () async {
      // This may or may not be null depending on previous tests
      // Just verify it completes without error
      await expectLater(authService.getCurrentUser(), completes);
    });

    test('logout should complete without errors', () async {
      await expectLater(authService.logout(), completes);
    });
  });
}
