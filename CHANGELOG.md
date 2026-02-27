# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- **Features**: `PreviewWrapper` for streamlined widget previews.
- **UI**: Added `circle_flags` package for enhanced language selection UI.
- **UI**: Added `AppBreakpoints` utility for responsive layouts and updated widgets to use it.
- **UI**: Added multi-layered drop shadows and "glow" effects to interactive elements.
- **UI**: Added background cards for unselected target languages.
- **CI/CD**: Added `coverage_check.yml` to prevent coverage regression and set enforcement threshold.
- **Docs**: Added AI agent rules for Cursor/Windsurf.
- **Dev**: Enabled `format_on_save` in VSCode settings.

### Changed
- **Refactor**: `LanguageSelectionScreen` now uses display names instead of native names for clarity.
- **Refactor**: Comprehensive theme consistency refactor across the application (semantic colors, spacing tokens).
- **Refactor**: Updated `GlotistButton` and other primitives to use centralized theme tokens.
- **Refactor**: Implemented logic to distinguish between display and target languages in repositories.
- **CI/CD**: Updated `husky` pre-push hook configuration.
- **Linting**: Removed deprecated rules (`unsafe_html`, API docs) from `analysis_options.yaml`.

### Fixed
- **UI**: Resolved dark mode card fill color regressions.
- **UI**: Restored the "See All" languages button.
- **Logic**: Fixed initial language selection to avoid hardcoded defaults.
- **Tests**: Resolved failing golden tests and updated `golden_toolkit` configuration.
- **Tests**: Implemented stricter test assertions for localization verification.
- **Style**: Fixed linting errors (line lengths, unawaited futures).

## [1.0.0+1] - 2026-01-25

### Added
- Complete Clean Architecture structure.
- Internationalization support (English, Turkish, Dutch).
- Core infrastructure layers (`config`, `constants`, `errors`, `theme`, `utils`).
- Asset organization (`images`, `fonts`, `translations`).
- Detailed architecture documentation and contribution guidelines.
- Deployment of `.env.example` for environment configuration.
