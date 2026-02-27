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

- [ ] Update `app_test.dart` flow once onboarding is finalized:
  - Flow: Language Selection -> Onboarding Conversation -> Profile Screen -> Dashboard -> Lesson (Quick, Cards, Replik, Full).

### UI Design

Areas needing design work:

- [ ] **Onboarding (Discussion/Chat Flow)**:
  - Add "Skip to manual selection" option during discussion (or allow both in the same UI).
  - User can speak/write in native language; app translates and teaches translation.
  - Topics: Basic info, learning goals, current levels, interests.
  - Ending: Engaging story connecting target and native languages (including other known languages).
- [ ] **Main Page (Dashboard)**: Incorporate "Fluently" screens concept.
- [ ] **Chat Page**: Research offline support with Gemma 3 models.
- [ ] **Settings Page**
- [ ] **Profile Page**: Include user data and settings collection during onboarding.
- [ ] **Curriculum Page**

### Future Improvements

- [ ] **GenUI SDK**: Integrate GenUI SDK for Flutter packages in chats (https://docs.flutter.dev/ai/genui).
- [ ] **AI Agents Architecture**: Design how AI agents communicate (Reference: https://gemini.google.com/share/d004dcd1ba3d).
- [ ] **Pronunciation Architecture**: Live two-layer architecture (Reference: https://gemini.google.com/app/6783dbd2cd02bbc9).
- [ ] **Karaoke Learning**: Learn with songs/lyrics. Also consider "Replique Learning" with movie lines.
- [ ] **Gamification**: Research video concepts from online platforms to make learning more fun.
- [ ] **Reading**: Explore "Learn any language through reading" concepts.
- [ ] **Flutter AI Rules**: https://docs.flutter.dev/ai/ai-rules
