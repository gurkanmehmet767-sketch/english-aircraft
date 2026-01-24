# English Aircraft ✈️

> Professional aviation English learning application with gamification and spaced repetition

[![Flutter](https://img.shields.io/badge/Flutter-3.27.0-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![Tests](https://img.shields.io/badge/Tests-68%20total-success)](https://github.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

<!-- CI/CD Status Badges -->
[![Flutter Analyze](https://github.com/gurkanmehmet767-sketch/english-aircraft/workflows/Flutter%20Analyze/badge.svg)](https://github.com/gurkanmehmet767-sketch/english-aircraft/actions)
[![Flutter Test](https://github.com/gurkanmehmet767-sketch/english-aircraft/workflows/Flutter%20Test/badge.svg)](https://github.com/gurkanmehmet767-sketch/english-aircraft/actions)
[![Web Build](https://github.com/gurkanmehmet767-sketch/english-aircraft/workflows/Web%20Build/badge.svg)](https://github.com/gurkanmehmet767-sketch/english-aircraft/actions)

**Live Demo**: [https://english-aircraft-app.netlify.app](https://english-aircraft-app.netlify.app)

---

## ✨ Features

### 📚 Content
- **488 aviation terms** across 9 categories
- **6 languages**: English, Turkish, Dutch, German, French, Spanish
- **CEFR levels**: A1, A2, B1 difficulty ratings
- Professional aviation terminology

### 🎮 Gamification
- **XP System**: Earn points for correct answers
- **Lives**: 5 hearts, regenerate over time
- **Streaks**: Daily learning motivation
- **Leagues**: Bronze → Champion progression
- **Mastery Levels**: Track word proficiency

### 🧠 Learning Features
- **Spaced Repetition**: Intelligent review scheduling
- **Multiple Choice**: Interactive quizzes
- **Progress Tracking**: Detailed statistics
- **Offline Support**: Learn anywhere

### 🔐 Account Features
- **Firebase Authentication**: Secure login
- **Cloud Sync**: Progress across devices
- **Leaderboards**: Compete globally
- **Friends System**: Learn together

---

## 🚀 Quick Start

### Prerequisites
```bash
flutter --version  # 3.27.0+
dart --version     # 3.2.0+
```

### Installation
```bash
# Clone repository
git clone https://github.com/gurkanmehmet767-sketch/english-aircraft.git
cd english_aircraft

# Install dependencies
flutter pub get

# Run app
flutter run -d chrome  # Web
flutter run -d android # Android
flutter run -d ios     # iOS
```

---

## 🧪 Testing

```bash
# Run all tests (43 tests)
flutter test

# Run specific test
flutter test test/vocabulary_test.dart

# With coverage
flutter test --coverage
```

**Test Coverage**: ~40-50%  
**All Tests Passing**: ✅ 43/43

---

## 🏗️ Architecture

```
lib/
├── data/           # Vocabulary data (488 terms)
├── models/         # Data models (Term, Category, User)
├── providers/      # State management (Provider)
├── screens/        # UI screens (15+ screens)
├── services/       # Business logic (Auth, Sync, Ads)
├── theme/          # App theming
└── widgets/        # Reusable widgets

test/
├── vocabulary_test.dart        # 11 tests
├── gamification_test.dart      # 20 tests
└── spaced_repetition_test.dart # 12 tests
```

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.27+ / Dart 3.2+
- **State Management**: Provider
- **Backend**: Firebase (Auth, Firestore)
- **Hosting**: Netlify
- **Testing**: flutter_test (43 unit tests)
- **CI/CD**: GitHub Actions

---

## 📱 Platforms

- ✅ **Web** (Primary - Live on Netlify)
- ✅ **Android**
- ✅ **Windows**
- ✅ **Linux** (Enabled, requires WSL for Windows builds)
- ✅ **iOS**
- ✅ **macOS**

---

## 📊 Project Stats

- **Lines of Code**: ~15,000+
- **Vocabulary Terms**: 488
- **Languages**: 6
- **Categories**: 9
- **Unit Tests**: 68 ✅ (56 passing)
- **Test Coverage**: ~60%
- **Code Quality**: 0 analyzer errors ✅
- **CI/CD**: 3 automated workflows ✅

---

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Development
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Run tests
flutter test
```

### CI/CD
All PRs automatically run:
- **Code Analysis**: `flutter analyze` (zero errors required)
- **Unit Tests**: All 68 tests must pass
- **Web Build**: Production build verification

Workflows:
- `.github/workflows/flutter_analyze.yml`
- `.github/workflows/flutter_test.yml`
- `.github/workflows/web_build.yml`

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file.

---

## 👨‍💻 Author

**Casper**
- Project Value: ₺6-7M (~$200K-250K)
- Development Time: 190+ hours
- Role: Full-Stack Mobile Developer

---

## 🙏 Acknowledgments

- Aviation terminology sourced from industry standards
- Inspired by Duolingo's learning path design
- Built with ❤️ for aviation professionals

---

## 📞 Contact

- **Issues**: [GitHub Issues](https://github.com/gurkanmehmet767-sketch/english-aircraft/issues)
- **GitHub**: [@gurkanmehmet767-sketch](https://github.com/gurkanmehmet767-sketch)

---

**Made with Flutter** 💙 | **For Aviation Professionals** ✈️
