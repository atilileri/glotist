# Navigation Guide

This document explains the routing and navigation system used in the Glotist app.

## Overview

Glotist uses **GoRouter** for declarative navigation, providing support for deep linking, type-safe routing, and a clear navigation structure. GoRouter is configured in [lib/core/router/app_router.dart](../lib/core/router/app_router.dart).

## Routing Architecture

The app uses a flat routing structure with named routes that map to specific screens. All navigation is handled through GoRouter's declarative API using `context.push()`, `context.go()`, and `context.pop()`.

## Route Structure

### Current Routes

The Glotist app currently has the following routes:

| Route        | Path            | Screen                         | Purpose                                                                   |
| ------------ | --------------- | ------------------------------ | ------------------------------------------------------------------------- |
| Home         | `/`             | `LanguageSelectionScreen`      | Initial onboarding step - users select display and target languages       |
| Choice       | `/choice`       | `OnboardingChoiceScreen`       | Second onboarding step - users choose learning path                       |
| Conversation | `/conversation` | `OnboardingConversationScreen` | Third onboarding step - AI-powered conversation for profile customization |

### Route Configuration

```dart
// lib/core/router/app_router.dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/choice',
      builder: (context, state) => const OnboardingChoiceScreen(),
    ),
    GoRoute(
      path: '/conversation',
      builder: (context, state) => const OnboardingConversationScreen(),
    ),
  ],
);
```

## Navigation Patterns

### Basic Navigation

#### Push a New Route (Stacking)

```dart
// Go to the choice screen while maintaining history
context.push('/choice');

// Go back to the previous screen
context.pop();
```

#### Replace Current Route (No History)

```dart
// Navigate to conversation screen, replacing current route
context.go('/conversation');
```

### Named Routes

Currently, routes are identified by their path (string). When adding more routes, consider using named routes for better type safety:

```dart
// Future enhancement: Use named routes
GoRoute(
  name: 'choice',
  path: '/choice',
  builder: (context, state) => const OnboardingChoiceScreen(),
),

// Usage
context.pushNamed('choice');
```

### Route Parameters

For routes that require parameters, use path parameters:

```dart
GoRoute(
  path: '/details/:id',
  builder: (context, state) {
    final String id = state.pathParameters['id']!;
    return DetailScreen(id: id);
  },
),

// Usage
context.push('/details/123');
```

### Query Parameters

```dart
GoRoute(
  path: '/search',
  builder: (context, state) {
    final String? query = state.uri.queryParameters['q'];
    return SearchScreen(query: query);
  },
),

// Usage
context.push('/search?q=flutter');
```

## Deep Linking

GoRouter supports deep linking out of the box. Deep links allow users to navigate directly to a specific screen via URLs.

### Web Examples

```
https://myapp.com/
https://myapp.com/choice
https://myapp.com/conversation
```

## Nested Routes (Subroutes)

For organizing related screens, use nested routes:

```dart
GoRoute(
  path: '/onboarding',
  builder: (context, state) => const OnboardingContainer(),
  routes: <RouteBase>[
    GoRoute(
      path: 'language',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: 'choice',
      builder: (context, state) => const OnboardingChoiceScreen(),
    ),
  ],
),

// Usage
context.push('/onboarding/language');
```

## Error Handling

GoRouter provides error handling with custom error screens:

```dart
final router = GoRouter(
  routes: [ /* ... */ ],
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error,
  ),
);
```

## Navigation Middleware (Redirects)

Use `redirect` to enforce authentication and authorization:

```dart
final router = GoRouter(
  routes: [ /* ... */ ],
  redirect: (context, state) {
    // Check if user is authenticated
    final isAuthenticated = /* check auth state */;
    final isLoggingIn = state.location == '/login';

    if (!isAuthenticated && !isLoggingIn) {
      return '/login'; // Redirect to login
    }

    if (isAuthenticated && isLoggingIn) {
      return '/'; // Redirect authenticated users away from login
    }

    return null; // Allow navigation
  },
);
```

## Integration with Material App

GoRouter is integrated into the app via `MaterialApp.router`:

```dart
// lib/main.dart
MaterialApp.router(
  title: 'Glotist',
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: themeMode,
  locale: locale,
  routerConfig: router, // GoRouter configuration
  localizationsDelegates: [ /* ... */ ],
  supportedLocales: AppLocalizations.supportedLocales,
);
```

## Navigation in Screens

### Using GoRouter in Widgets

```dart
import 'package:go_router/go_router.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.push('/choice'),
      child: const Text('Next Step'),
    );
  }
}
```

### Building Navigation UI

```dart
ElevatedButton(
  onPressed: () async {
    final result = await context.push<String>('/conversation');
    if (result != null) {
      // Handle returned data
      print('Returned: $result');
    }
  },
  child: const Text('Open Conversation'),
);
```

## Dialog and Bottom Sheets

For temporary UI that doesn't require deep linking, use the built-in `Navigator`:

```dart
// Show a dialog (doesn't affect route history)
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Confirm?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    ],
  ),
);

// Show a bottom sheet
showModalBottomSheet(
  context: context,
  builder: (context) => const SettingsSheet(),
);
```

## Best Practices

1. **Use GoRouter for Navigation:** Always use GoRouter's `push()`, `go()`, and `pop()` for screen-to-screen navigation.

2. **Avoid Navigator.push():** Reserve Navigator for dialogs, bottom sheets, and temporary overlays that don't need deep-linking support.

3. **Type Safety:** Consider using `go_router_builder` generator for type-safe routes.

4. **Named Routes:** Name important routes for clarity and refactoring safety.

5. **Consistent Naming:** Use kebab-case for route paths (e.g., `/user-profile`, `/settings-preferences`).

6. **Error Handling:** Always define an error screen for handling navigation errors.

7. **Authentication:** Use the `redirect` callback to enforce authentication flows.

8. **Deep Links:** Design routes with web and deep linking in mind from the start.

## Future Enhancements

- [ ] Add authentication redirects to enforce login flows
- [ ] Implement nested routes for feature organization
- [ ] Use `go_router_builder` for code generation and type safety
- [ ] Add named routes for better maintainability
- [ ] Implement route guards for permission-based navigation

## Related Files

- **Router Configuration:** [lib/core/router/app_router.dart](../lib/core/router/app_router.dart)
- **Main App:** [lib/main.dart](../lib/main.dart)
- **AI Rules:** [.github/instructions/ai-rules-for-flutter-and-dart.instructions.md](../.github/instructions/ai-rules-for-flutter-and-dart.instructions.md)
- **Architecture Guide:** [docs/architecture.md](architecture.md)

## Resources

- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Effective Dart Navigation](https://dart.dev/guides)
- [Flutter Navigation Best Practices](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
