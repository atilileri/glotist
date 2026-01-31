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
2.  Fill in your Supabase, Google AI, and translation credentials:
    ```
    SUPABASE_URL=your_supabase_project_url
    SUPABASE_ANON_KEY=your_supabase_anon_key
    GOOGLE_AI_API_KEY=your_gemini_api_key
    ARB_TRANSLATE_API_KEY=your_gemini_or_arb_translate_key_here
    ```
    `ARB_TRANSLATE_API_KEY` is required for running `arb_translate` to generate
    translations for ARB files (and optionally for `flutter gen-l10n` when using
    translation). Use the same Gemini API key as `GOOGLE_AI_API_KEY` or a
    dedicated key; never commit it to the repo.

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

## Generating translations

To translate ARB files with `arb_translate`, set `ARB_TRANSLATE_API_KEY` in your
`.env` (see Environment Variables). Then either:

- Run the helper script (loads `.env` and runs `arb_translate`):
  ```powershell
  .\scripts\translate.ps1
  ```
- Or set the variable and run manually:
  ```powershell
  $env:ARB_TRANSLATE_API_KEY = "your_key"
  dart pub global run arb_translate
  ```

After translating, run `flutter gen-l10n` to regenerate Dart localizations.
