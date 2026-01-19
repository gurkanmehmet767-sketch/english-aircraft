# Contributing to English Aircraft

## Development Workflow

### Prerequisites
- Flutter 3.27.0 or higher
- Dart SDK 3.2.0 or higher
- Firebase CLI (for deployment)

### Setup
```bash
# Clone the repository
git clone https://github.com/yourusername/english_aircraft.git
cd english_aircraft

# Install dependencies
flutter pub get

# Run the app
flutter run -d chrome
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/vocabulary_test.dart

# Run with coverage
flutter test --coverage
```

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Check format
dart format --set-exit-if-changed .
```

### CI/CD Pipeline

All pull requests and pushes automatically trigger:
1. ✅ Code analysis (`flutter analyze`)
2. ✅ Format check (`dart format`)
3. ✅ Unit tests (43 tests)
4. ✅ Build web (`flutter build web`)
5. ✅ Deploy to Netlify (main branch only)

### Pull Request Process

1. Create a feature branch
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit
   ```bash
   git add .
   git commit -m "feat: your feature description"
   ```

3. Run tests locally
   ```bash
   flutter test
   flutter analyze
   ```

4. Push and create PR
   ```bash
   git push origin feature/your-feature-name
   ```

5. Wait for CI checks to pass ✅

### Commit Message Convention

Use conventional commits:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `test:` Tests
- `refactor:` Code refactoring
- `style:` Formatting
- `chore:` Maintenance

### Code Standards

- Follow Dart style guide
- Write tests for new features
- Keep code coverage > 40%
- No warnings in `flutter analyze`
- Format code before committing

### Testing Guidelines

- Write unit tests for business logic
- Test edge cases
- Mock external dependencies
- Aim for >80% coverage

---

**Questions?** Open an issue or contact the maintainers.
