---
description: Maintain and update project documentation
---

This workflow guides the AI in systematically updating project documentation.

## 1. Preparation
- Read the following files to understand the current state:
  - `notes.private.md`
  - `TODO.md`
  - `README.md`
  - `CHANGELOG.md`
  - `CONTRIBUTING.md`
  - `pubspec.yaml`
  - `analysis_options.yaml`

- **Analyze Recent Changes**:
  - Run `git log -n 30 --stat` to see commit messages and file statistics.
  - Identify key areas of impact (e.g., UI, logic, tests, dependencies).
  - Note any major refactors or new features based on the file paths and commit descriptions.

## 2. Update TODOs
- Scan `notes.private.md` for actionable items (features, bugs, tech debt, UI tasks).
- Move fully formed tasks to `TODO.md` under appropriate sections.
- **Important**: Do NOT modify `notes.private.md`. It is a read-only source. Just copy the relevant items to `TODO.md`.

## 3. Update README
- Verify the "Tech Stack" section in `README.md` matches `pubspec.yaml` dependencies.
- Update "Project Structure" if file layout has changed significantly.
- Update "Getting Started" if setup scripts or requirements have changed.

## 4. Update Contributing Guidelines
- Check `analysis_options.yaml` for any new linting rules that should be mentioned.
- Check `.github/workflows` for CI/CD changes that affect the contribution process (e.g. new checks).
- Update `CONTRIBUTING.md` accordingly.

## 5. Update Changelog
- Using the `git log` output from step 1, update `CHANGELOG.md`.
- Add a new `## [Unreleased]` section if not present.
- Categorize recent changes into `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`.

## 6. Final Review
- Present a summary of changes to the user.
- Ask for confirmation before applying large edits to `README.md` or `CONTRIBUTING.md`.
