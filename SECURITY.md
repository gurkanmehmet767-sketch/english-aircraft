# Security Best Practices - English Aircraft

## API Key Security

### Firebase API Keys
**Location**: `lib/firebase_options.dart`

**Status**: ✅ SAFE

Firebase API keys in `firebase_options.dart` are **public by design** and safe to commit to version control. They are NOT secret keys.

**Why it's safe:**
1. Firebase API keys only identify your Firebase project
2. Actual security is enforced by:
   - **Firestore Security Rules** (`firestore.rules`)
   - **Firebase Authentication**
   - **App Check** (optional, for production)

**Protection Layers:**
- ✅ Firestore security rules prevent unauthorized data access
- ✅ Firebase Auth ensures only authenticated users can access protected resources
- ✅ Security rules validate user ownership before allowing updates

**Reference:**
- [Firebase: Is it safe to expose API keys?](https://firebase.google.com/docs/projects/api-keys)

---

## Firebase Security Rules

### Firestore Rules (`firestore.rules`)

**Implemented Protections:**

#### 1. User Data Protection
```javascript
match /users/{userId} {
  allow read: if true;  // Public profiles for leaderboards
  allow write: if isAuthenticated() && isOwner(userId);
}
```
- Public read for leaderboards and friend discovery
- Only owner can modify their profile

#### 2. Progress Data Protection
```javascript
match /users/{userId}/progress/{progressId} {
  allow read, write: if isAuthenticated() && isOwner(userId);
}
```
- Completely private - only owner can access

#### 3. Friend Requests
```javascript
match /friend_requests/{requestId} {
  allow read: if isAuthenticated() && 
    (sender || receiver);
  allow create: if isAuthenticated() && isSender;
}
```
- Only involved parties can access
- Prevents spam/unauthorized requests

---

## Authentication Security

### Password Security
**Implementation**: `lib/services/auth_service.dart`

**Protections:**
- ✅ SHA-256 password hashing (offline auth)
- ✅ Never store plaintext passwords
- ✅ Minimum 6 character requirement
- ✅ Email validation using `validators` package
- ✅ Username validation (3-20 chars, alphanumeric)

**Password Strength Checker:**
```dart
String getPasswordStrength(String password) {
  if (password.length < 6) return 'zayıf';
  if (password.length < 8) return 'orta';
  if (hasUppercase && hasNumber) return 'güçlü';
  return 'orta';
}
```

---

## Input Validation

### Auth Forms
**Location**: `lib/screens/auth_screen.dart`

**Client-Side Validation:**
- ✅ Email format validation
- ✅ Password strength checking
- ✅ Username format validation
- ✅ Real-time feedback to user

**Server-Side Validation:**
- ✅ AuthService validates before saving
- ✅ Firestore security rules double-check
- ✅ Firebase Auth validates on sync

---

## Data Sanitization

### User Input Handling

**Email:**
```dart
email.toLowerCase().trim()  // Normalize before storing
```

**Username:**
```dart
username.trim()  // Remove whitespace
RegExp(r'^[a-zA-Z0-9_]+$')  // Alphanumeric only
```

**Password:**
```dart
// Never exposed, only hash stored
_hashPassword(password)  // SHA-256
```

---

## Network Security

### HTTPS Enforcement
- ✅ Firebase automatically uses HTTPS
- ✅ Netlify enforces HTTPS on web
- ✅ No plain HTTP connections

### Connectivity Handling
- ✅ Offline-first prevents data exposure if intercepted
- ✅ Sync queue encrypts at device level
- ✅ No sensitive data in URL parameters

---

## Sensitive Data Handling

### What's Stored Where

**Local Storage (SharedPreferences):**
- User profile
- Password hash (SHA-256)
- Progress data
- Sync queue

**Firebase (Cloud):**
- User profile (public fields)
- Leaderboard data
- Friend relationships
- Progress data (protected by rules)

**Never Stored:**
- ❌ Plaintext passwords
- ❌ Payment information (not implemented)
- ❌ Personal identification numbers

---

## Security Checklist

### Pre-Deployment
- [x] Firestore security rules deployed
- [x] API keys documented as safe
- [x] Password hashing implemented
- [x] Input validation on all forms
- [x] HTTPS enforced
- [ ] App Check enabled (production)
- [ ] Rate limiting configured (production)

### Regular Audits
- [ ] Review Firestore rules quarterly
- [ ] Update dependencies (security patches)
- [ ] Monitor Firebase security alerts
- [ ] Review authentication logs

---

## Reporting Security Issues

**Contact:** 
- Email: [your security email]
- GitHub: Private security advisories

**Please DO NOT:**
- Open public issues for security vulnerabilities
- Share exploits publicly before patching

---

## Future Security Enhancements

### Planned
1. **App Check**: Add device attestation for production
2. **Rate Limiting**: Prevent brute force attacks
3. **Audit Logging**: Track authentication attempts
4. **Two-Factor Auth**: Optional 2FA for accounts
5. **Session Management**: Automatic logout on inactivity

### Considered
- Email verification before sync
- OAuth providers (Google, Apple Sign-In)
- End-to-end encryption for friend messages
- Privacy mode (hide from leaderboards)

---

**Last Updated**: January 2026  
**Review Date**: April 2026
