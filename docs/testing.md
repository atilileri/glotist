# Testing Guide

Glotist maintains a high level of code quality through comprehensive testing.

## Test Types

### 1. Unit Tests
Location: `test/` (e.g., `test/features/chat/domain/use_cases/get_messages_test.dart`)
Focus on testing individual functions, use cases, and repositories in isolation.

```bash
flutter test test/path/to/test.dart
```

### 2. Widget Tests
Location: `test/` (e.g., `test/features/onboarding/presentation/widgets/onboarding_button_test.dart`)
Verify UI components and their interactions.

```bash
flutter test test/features/onboarding/presentation/widgets/
```

### 3. Integration Tests
Location: `integration_test/` (e.g., `integration_test/app_test.dart`)
End-to-end tests that run on a physical device or emulator.

```bash
flutter test integration_test/app_test.dart
```

## Continuous Integration

We use GitHub Actions to run tests on every push and pull request. Static analysis is also enforced.

## Pre-commit Hooks

We use `Husky` and `lint_staged` to ensure that code is formatted and analyzed before every commit.

To manually run the pre-commit checks:
```bash
npx lint-staged
```
*(Requires Node.js for npx, or use the dart equivalents if configured)*
