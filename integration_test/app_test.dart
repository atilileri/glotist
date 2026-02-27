import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify onboarding flow and take screenshot', (tester) async {
    // We need to keep a reference to the original builder to reset it
    // because app.main() overrides it with AppErrorBoundary which confuses
    // the integration test framework.
    final originalErrorBuilder = ErrorWidget.builder;

    app.main();

    // Reset it immediately after initialization to avoid infra conflicts
    ErrorWidget.builder = originalErrorBuilder;

    await tester.pump();

    // 1. Language Selection Screen
    expect(find.text('DISPLAY LANGUAGE'), findsOneWidget);
    expect(find.byKey(const Key('display_language_dropdown')), findsOneWidget);

    // Take a screenshot of the initial screen
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await binding.takeScreenshot('language_selection_initial');

    // Tap Continue → navigates directly to conversation screen
    final continueButton = find.bySemanticsLabel('Continue to next step');
    await tester.tap(continueButton);
    await tester.pump();
    // Wait for internal navigation and initial timers
    await tester.pump(const Duration(seconds: 1));

    // 2. Onboarding Conversation Screen (choice screen bypassed)
    expect(find.text('Profile Setup'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Interests'), findsOneWidget);
    expect(find.text('Level'), findsOneWidget);
    expect(find.text('Purpose'), findsOneWidget);

    // Take a screenshot
    await binding.takeScreenshot('onboarding_conversation');

    // Enter text
    final inputFinder = find.byType(TextField);
    await tester.enterText(inputFinder, 'I want to learn Japanese');
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Take another screenshot after input
    await binding.takeScreenshot('onboarding_input');
  });
}
