# Setup Guide

This guide will help you set up the development environment for Glotist.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable)
- [Dart SDK](https://dart.dev/get-started/sdk)
- [Git](https://git-scm.com/downloads)
- VS Code or Android Studio with Flutter/Dart plugins.

## Environment Variables

The application uses environment variables for configuration. Use the provided template to create your `.env` file.

1.  Copy `.env.example` to `.env`:
    ```bash
    cp .env.example .env
    ```
2.  Fill in your Supabase and Gemini API credentials:
    ```
    SUPABASE_URL=your_supabase_project_url
    SUPABASE_ANON_KEY=your_supabase_anon_key
    GEMINI_API_KEY=your_gemini_api_key
    ```

## Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/atilileri/glotist.git
    cd glotist/glotist_app
    ```
2.  Install Flutter dependencies:
    ```bash
    flutter pub get
    ```
3.  Install Git hooks (Husky):
    ```bash
    dart run husky install
    ```

## Running the App

To run the application in debug mode:

```bash
flutter run
```

For web development:
```bash
flutter run -d chrome
```
