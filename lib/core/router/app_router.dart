import 'package:glotist_app/features/onboarding/presentation/pages/language_selection_screen.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/onboarding_conversation_screen.dart';
import 'package:go_router/go_router.dart';

/// Main router configuration for the application.
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LanguageSelectionScreen(),
    ),
    GoRoute(
      path: '/conversation',
      builder: (context, state) => const OnboardingConversationScreen(),
    ),
  ],
);
