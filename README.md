# Glotist App

[![Flutter Quality & Test Suite](https://github.com/atilileri/glotist/actions/workflows/main.yml/badge.svg)](https://github.com/atilileri/glotist/actions/workflows/main.yml)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)
[![style: very good analysis](https://img.shields.io/badge/style-very__good__analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
![GitHub last commit](https://img.shields.io/github/last-commit/atilileri/glotist)
![GitHub issues](https://img.shields.io/github/issues/atilileri/glotist)
![GitHub pull requests](https://img.shields.io/github/issues-pr/atilileri/glotist)

Values-driven language learning application.

## 🚀 Overview

Glotist is a modern Flutter application designed to provide a personalized language learning experience. It leverages AI to create custom curriculums based on the user's known languages and goals.

## 🛠️ Tech Stack

This project is built using a robust and modern technology stack:

-   **Framework**: [Flutter](https://flutter.dev/) (Channel stable)
-   **Language**: [Dart](https://dart.dev/)
-   **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
-   **Routing**: [go_router](https://pub.dev/packages/go_router) for declarative routing.
-   **Backend / Database**: [Supabase](https://supabase.com/) (using `supabase_flutter`)
-   **AI Integration**: [Google Generative AI](https://pub.dev/packages/google_generative_ai) (Gemini API)
-   **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
-   **Typography**: [google_fonts](https://pub.dev/packages/google_fonts)
-   **Linting**: `very_good_analysis` for strict code quality.

## 🏁 Getting Started

### Prerequisites

-   Flutter SDK installed (Run `flutter doctor` to verify)
-   An IDE (VS Code or Android Studio)
-   Supabase project credentials (if applicable for running full features)

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/glotist_app.git
    cd glotist_app
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    flutter run
    ```

## 🧪 Testing

### Static Analysis

We practice strict code analysis. Run the linter before committing:

```bash
flutter analyze
```

### Unit & Widget Tests

Run the test suite:

```bash
flutter test
```

### Integration Tests

To run integration tests on an emulator/device and verify UI flows:

```bash
flutter test integration_test/app_test.dart
```

*Note: You need an active emulator or device connected.*

## 📂 Project Structure

The project follows Clean Architecture principles with feature-based organization.

- `assets/`: App-wide assets (images, fonts, translations).
- `docs/`: Detailed project documentation.
- `l10n/`: Localization files (ARB).
- `lib/core/`: Common utilities, themes, errors, and DI.
- `lib/features/`: Feature-based logic.
    - `onboarding/`: Onboarding flow logic and UI.
    - `chat/`: Core chat functionality.
- `test/`: Comprehensive unit, widget, and integration tests mirroring the `lib` structure.

Refer to [architecture.md](docs/architecture.md) for a deep dive into the patterns used.

## 🌍 Internationalization

We support English as the base language, with Turkish and Dutch ready for implementation.

To generate localization files:
```bash
flutter gen-l10n
```

See the [l10n directory](l10n/) for translation files.
