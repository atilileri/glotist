# Contributing to Glotist

Thank you for your interest in contributing to Glotist! This document provides guidelines for maintaining a clean and consistent codebase.

## Code Style

- Follow the official [Dart Style Guide](https://dart.dev/guides/language/evolutionary-style).
- Use `very_good_analysis` lints (included in the project).
- Run `dart format .` before committing.

## Commit Guidelines

- Use descriptive commit messages.
- Prefer conventional commits format (e.g., `feat: ...`, `fix: ...`, `docs: ...`).

## Architecture Compliance

- Always follow the Clean Architecture layers when adding new features.
- Keep the `domain` layer free of external dependencies (except for basic dart/flutter packages if essential).
- Place shared logic in `lib/core`.

## Testing

- Every new feature should include unit tests for its domain and data layers.
- Widget tests should be provided for major UI components.
- Run `flutter test` to ensure no regressions.

## Documentation

- Document public APIs using triple-slash (`///`) comments.
- Update `CHANGELOG.md` for significant changes.
- Add/update files in the `docs/` directory for major architectural decisions.

## Project Roadmap

Check [TODO.md](TODO.md) for the current roadmap and how to add tasks.

## Directory Placeholders

> [!IMPORTANT]
> Some directories contain `README.md` files as placeholders for documentation. **Please remove these files** once you add actual implementation files to those directories.
