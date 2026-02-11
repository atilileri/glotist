# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- **Features**: `PreviewWrapper` for streamlined widget previews.
- **UI**: Added `circle_flags` package for enhanced language selection UI.
- **CI/CD**: Added `coverage_check.yml` to prevent coverage regression.
- **Docs**: Added AI agent rules for Cursor/Windsurf.
- **Dev**: Enabled `format_on_save` in VSCode settings.

### Changed
- **Refactor**: `LanguageSelectionScreen` now uses display names instead of native names for clarity.
- **CI/CD**: Updated `husky` pre-push hook configuration.
- **Linting**: Removed deprecated rules (`unsafe_html`, API docs) from `analysis_options.yaml`.

### Fixed
- **Tests**: Resolved failing golden tests and updated `golden_toolkit` configuration.
- **Style**: Fixed linting errors (line lengths, unawaited futures).

## [1.0.0+1] - 2026-01-25

### Added
- Complete Clean Architecture structure.
- Internationalization support (English, Turkish, Dutch).
- Core infrastructure layers (`config`, `constants`, `errors`, `theme`, `utils`).
- Asset organization (`images`, `fonts`, `translations`).
- Detailed architecture documentation and contribution guidelines.
- Deployment of `.env.example` for environment configuration.
