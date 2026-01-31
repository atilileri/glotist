# TODO

Public roadmap for contributors. Private notes (personal TODOs) live in
`notes.private.md` (gitignored).

# How to Use

- **Add tasks** that others can work on; keep personal or sensitive notes in
  `notes.private.md`.
- Use **short, scannable items**; prefer issues and PRs for detailed discussion.
- Follow existing formatting and categories.
- See [CONTRIBUTING.md](CONTRIBUTING.md) for code style, commits, and
  architecture.

---

## Overview

### Onboarding

- Rename "Native Language" to "App Language"; add flags; show languages in
  their native form
- Update language selection to dropdown/input with flags
- Remove "Other languages" section; gather languages and levels via onboarding
  conversation
- Improve UX on language selection screen (titles, welcoming copy)

### CI/CD

- Add tests to GitHub Actions pipeline

### UI Design

Areas needing design work:

- Onboarding (discussion/chat flow)
- Main page
- Chat page
- Settings page
- Profile page (incl. user data and settings from onboarding)
- Curriculum page

### Future Improvements

- Integrate GenUI SDK for Flutter in chat:
  https://docs.flutter.dev/ai/genui
- Add Flutter AI rules: https://docs.flutter.dev/ai/ai-rules
