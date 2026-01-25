# Glotist App

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

-   `lib/core`: Core utilities, DI setup, and shared services.
-   `lib/features`: Feature-based architecture (Clean Architecture).
    -   `onboarding`: Onboarding flow screens and logic.
    -   `chat`: Chat functionality for AI interaction.
