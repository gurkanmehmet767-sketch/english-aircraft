# English Aircraft - Architecture Documentation

## Overview

English Aircraft is a Flutter-based aviation English learning application built with an **offline-first architecture** featuring gamification, spaced repetition, and multi-language support.

---

## Technology Stack

### Frontend
- **Framework**: Flutter 3.27+ / Dart 3.2+
- **State Management**: Provider pattern
- **UI**: Material Design with custom theming

### Backend & Services
- **Authentication**: Firebase Auth + Offline auth with local storage
- **Database**: Cloud Firestore (online) + SharedPreferences (offline)
- **Hosting**: Netlify (web deployment)
- **CI/CD**: GitHub Actions

### Key Dependencies
- `provider` - State management
- `shared_preferences` - Local data persistence
- `firebase_core`, `firebase_auth`, `cloud_firestore` - Backend services
- `connectivity_plus` - Network status detection
- `crypto`, `uuid` - Offline authentication
- `google_fonts` - Typography
- `flutter_markdown` - Legal document rendering

---

## Architecture Pattern

### Offline-First Design

The application follows an offline-first architecture where all core functionality works without internet:

```
User Action → AppProvider → LocalStorageService → UI Update
                    ↓
            (when online)
                    ↓
              SyncService → FirestoreService → Firebase
```

**Benefits**:
- Instant response times
- Works in low/no connectivity
- Seamless online/offline transitions
- Data safety with local persistence

---

## Project Structure

```
lib/
├── data/              # Static vocabulary data
│   ├── vocabulary_data_fixed.dart  # 488 aviation terms
│   └── word_dictionary.dart         # Multi-language dictionary
│
├── models/            # Data models
│   ├── vocabulary_models.dart      # Term, Category, League
│   └── user_model.dart             # User data structure
│
├── providers/         # State management
│   └── app_provider.dart           # Main application state
│
├── screens/           # UI screens (18 screens)
│   ├── home_screen.dart            # Learning path
│   ├── lesson_screen.dart          # Quiz interface
│   ├── auth_screen.dart            # Login/Register
│   ├── settings_screen.dart        # App settings
│   └── ...
│
├── services/          # Business logic
│   ├── auth_service.dart           # Offline authentication
│   ├── sync_service.dart           # Data synchronization
│   ├── firestore_service.dart      # Firebase operations
│   ├── local_storage_service.dart  # Local persistence
│   └── ad_service.dart             # Advertisement (mobile)
│
├── theme/             # App theming
│   └── app_theme.dart              # Light/dark themes
│
├── utils/             # Utilities
│   └── ...
│
└── widgets/           # Reusable widgets
    └── ...
```

---

## Core Components

### 1. AppProvider (State Management)

Central state manager using Provider pattern:
- User progress (XP, lives, streaks)
- Lesson completion tracking
- Theme management
- Sync status

**Key Methods**:
- `completeLesson()` - Updates progress after lesson
- `updateLives()` - Manages lives system
- `toggleTheme()` - Switches light/dark mode

---

### 2. Authentication System

**Offline-First Auth**:
```
Registration → Validate inputs → Hash password (SHA-256)
            → Generate temp UUID → Save locally
            → Add to sync queue → (sync when online)
```

**Features**:
- Email/password validation
- Password strength checking (weak/medium/strong)
- Local credential storage
- Automatic sync to Firebase when online

**Files**:
- `auth_service.dart` - Authentication logic
- `user_model.dart` - User data structure

---

### 3. Synchronization System

**Queue-Based Sync**:
```
Offline Action → Add to sync queue → Save locally
                                    ↓
                          (when connectivity available)
                                    ↓
                    Process queue → Sync to Firebase → Clear queue
```

**Sync Types**:
- `user_create` - New user registration
- `user_update` - Profile changes
- `password_change` - Password updates
- `friend_request` - Social features

**Files**:
- `sync_service.dart` - Sync orchestration
- `firestore_service.dart` - Firebase operations
- `local_storage_service.dart` - Local persistence

---

### 4. Learning System

**Gamification Features**:
- **XP System**: 10 XP per correct answer + streak bonus
- **Lives**: 5 max, regenerate 1/30min
- **Streaks**: Daily completion tracking
- **Leagues**: Bronze → Silver → Gold → Platinum → Diamond → Champion
- **Mastery Levels**: 0 (new) → 4 (mastered)

**Spaced Repetition**:
```
Review Count → Interval
1st review   → 1 day
2nd review   → 3 days
3rd review   → 7 days
4th review   → 14 days
5th+ review  → 30+ days
```

**Files**:
- Providers handle game state
- Vocabulary models define structure

---

### 5. Data Models

#### Term Model
```dart
class Term {
  final String english;
  final String turkish;
  final String level;  // A1, A2, B1
  final String? dutch, german, french, spanish;
}
```

#### CategoryData
```dart
class CategoryData {
  final String title;
  final String icon;
  final String section;
  final List<Term> terms;
  final List readings;
}
```

#### UserModel
```dart
class UserModel {
  final String uid;
  final String email;
  final String username;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime lastActive;
}
```

---

## Data Flow

### Lesson Completion Flow

```
1. User completes lesson
       ↓
2. AppProvider.completeLesson()
       ↓
3. Calculate XP (base + streak bonus)
       ↓
4. Update lives, XP, mastery
       ↓
5. Save to LocalStorage
       ↓
6. Add to sync queue
       ↓
7. UI updates immediately
       ↓
8. (when online) SyncService processes queue
```

---

## Testing Strategy

### Test Coverage (68 tests)

**Unit Tests**:
- `vocabulary_test.dart` (11 tests) - Data models
- `gamification_test.dart` (20 tests) - Game logic
- `spaced_repetition_test.dart` (12 tests) - Review algorithm
- `ad_service_test.dart` (11 tests) - Ad service
- `auth_service_test.dart` (7 tests) - Authentication
- `sync_service_test.dart` (7 tests) - Synchronization

**Widget Tests**:
- `widget_test.dart` (1 test) - App smoke test

**Test Pattern**:
```dart
group('Feature Tests', () {
  late Service service;
  
  setUp(() => service = Service());
  
  test('should do something', () {
    expect(service.method(), expectedValue);
  });
});
```

---

## CI/CD Pipeline

### GitHub Actions Workflows

**1. Flutter Analyze** (`.github/workflows/flutter_analyze.yml`)
- Runs on every push/PR
- Enforces zero analyzer errors

**2. Flutter Test** (`.github/workflows/flutter_test.yml`)
- Runs all 68 tests
- Uploads test results as artifacts

**3. Web Build** (`.github/workflows/web_build.yml`)
- Verifies production web build
- Uploads build artifacts

---

## Deployment

### Web (Netlify)
- Automatic deployment from `main` branch
- Custom domain support
- PWA-ready with offline capabilities
- Live at: https://cool-lily-c480e7.netlify.app

### Mobile (Future)
- Android: Google Play Store (planned)
- iOS: App Store (planned)

---

## Performance Considerations

### Optimization Strategies
1. **Lazy Loading**: Vocabulary loaded on-demand
2. **Local-First**: Instant UI updates, sync in background
3. **Minimal Rebuilds**: Provider pattern with selective listening
4. **Asset Optimization**: Compressed images, fonts
5. **Code Splitting**: Route-based lazy loading

### Metrics
- **App Size**: ~5-10MB (web)
- **Initial Load**: <3s (web)
- **Vocabulary**: 488 terms across 9 categories
- **Supported Languages**: 6 (EN, TR, NL, DE, FR, ES)

---

## Security

### Authentication Security
- **Password Hashing**: SHA-256 for offline auth
- **Firebase Auth**: Secure token-based authentication
- **Input Validation**: Email/username/password validation
- **No Plaintext**: Passwords never stored in plain text

### Data Security
- Local: SharedPreferences (encrypted on device)
- Cloud: Firebase security rules
- API Keys: Environment variables (not committed)

---

## Future Enhancements

### Planned Features
1. **Social Features**: Friends, leaderboards, challenges
2. **Advanced Audio**: Native TTS for pronunciation
3. **Progress Analytics**: Detailed learning statistics
4. **Custom Lessons**: User-created vocabulary sets
5. **Achievement System**: Badges and milestones

### Technical Improvements
1. **Test Coverage**: Increase to 80%+
2. **Widget Tests**: Add for all critical screens
3. **E2E Testing**: Integration test suite
4. **Performance Monitoring**: Firebase Performance
5. **Crash Reporting**: Firebase Crashlytics

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

**Key Points**:
- Follow existing architecture patterns
- Write tests for new features
- Update documentation
- Pass all CI/CD checks

---

**Last Updated**: January 2026
**Version**: 1.0.0
**Maintainer**: Casper
