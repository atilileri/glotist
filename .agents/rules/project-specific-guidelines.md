---
trigger: always_on
---

# Project Specific Guidelines

## Overview
This file contains custom instructions and architectural rules specifically tailored for the **Glotist** Flutter project. All AI agents working on this project must strictly adhere to these rules to ensure consistency, maintainability, and correct architectural alignment.

These instructions should be configured as the primary custom instructions / workspace rules in your AI coding assistant.

---

## 1. Architectural Alignment
*   **Routing:** Use `go_router` for all navigation and deep linking.
*   **Backend:** Use `supabase_flutter` for authentication and database interactions.
*   **State Management / DI:** Use `flutter_bloc` (Blocs and Cubits) for application and server state, and `get_it` for dependency injection.
*   **Structure:** Follow a strict Feature-First modular structure (`lib/features/[feature_name]/...`).

## 2. Strict Centralized Theming (The "No Hardcoding" Rule)
*   **CRITICAL RULE:** **NEVER** use inline colors (e.g., `Colors.red`, `Color(...)`) or hardcoded styling values (e.g., `fixed font sizes`, `padding: 16.0`) directly in widgets.
*   **Colors & Typography:** Use custom `BuildContext` extensions (`context.colorScheme`, `context.textTheme` from `lib/core/theme/theme_extensions.dart`) to access defined colors and text styles. This ensures clean code and seamless Light/Dark mode transitions dynamically resolved via `Theme.of(context)`.
*   **Spacing:** Use the static class `AppSpacing` (e.g., `AppSpacing.md`, `AppSpacing.lg` from `lib/core/theme/app_spacing.dart`) for all padding, margins, gaps, and border radii instead of hardcoded magic numbers. This provides extreme performance (`const`) while maintaining rigid layout consistency.

## 3. UI Primitive Component Library
Every feature must build its UI using the shared primitive component library, rather than using raw Flutter framework widgets directly.
*   Do not use raw `ElevatedButton`, `TextField`, `Card`, etc., directly in feature screens.
*   Instead, use the Glotist-specific primitives (e.g., `GlotistButton`, `GlotistTextField`, `GlotistCard`) defined in `lib/core/presentation/widgets/`.
*   If a required primitive does not exist yet (e.g., based on the designs in `language_selection_screen`), **create it first** in the core widgets directory before using it. This ensures ultimate design consistency across the entire app.

## 4. State Separation: Ephemeral vs. App State
*   **Ephemeral (Local UI) State:** State that only matters to a single widget and doesn't need to be saved or shared globally.
    *   *Example:* Whether a dropdown is currently open, what text is currently typed inside a search bar, animations, or the currently highlighted language card before pressing continue.
    *   *How to handle:* Use `setState` or `ValueNotifier`. Do not create a complex Bloc/Cubit for simple UI state.
*   **App / Server State:** Data that comes from the backend or needs to be shared across multiple screens.
    *   *Example:* The actual list of languages downloaded from Supabase, or the currently logged-in User profile.
    *   *How to handle:* Fetch it using a specific `Repository`, and store it in an injected `LocalizationCubit` or `AuthBloc` so any screen can access it reactively.

## 5. UI Error Boundaries
*   To prevent the app from showing Flutter's grey screen or "Red Screen of Death" when rendering errors occur, an app-level Error Boundary is utilized.
*   The class `AppErrorBoundary` (`lib/core/presentation/widgets/app_error_boundary.dart`) is hooked natively into `ErrorWidget.builder` inside `main.dart`.
*   If you are building risky widget trees or custom integrations, you can also manually wrap those segments in `AppErrorBoundary` (with mock details) to gracefully fail without crashing the whole application layer.
