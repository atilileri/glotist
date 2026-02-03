import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify onboarding flow and take screenshot', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 1. Language Selection Screen
    expect(find.text('DISPLAY LANGUAGE'), findsOneWidget);
    expect(find.byKey(const Key('native_language_dropdown')), findsOneWidget);

    // Take a screenshot of the initial screen
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await binding.takeScreenshot('language_selection_initial');

    // Tap Continue
    final continueButton = find.bySemanticsLabel('Continue to next step');
    await tester.tap(continueButton);
    await tester.pumpAndSettle();

    // 2. Onboarding Choice Screen
    expect(find.text('Start Your Journey'), findsOneWidget);
    await binding.takeScreenshot('onboarding_choice');

    // Tap Create Profile & Customize
    final customizeChoice = find.text('Create Profile & Customize');
    await tester.tap(customizeChoice);
    await tester.pumpAndSettle();

    // 3. Onboarding Conversation Screen
    // We expect to see the Onboarding Assistant
    expect(find.text('Onboarding Assistant'), findsOneWidget);

    // Take a screenshot
    await binding.takeScreenshot('onboarding_conversation');

    // Enter text
    final inputFinder = find.byType(TextField);
    await tester.enterText(inputFinder, 'I want to learn Japanese');
    await tester.pumpAndSettle();

    // Take another screenshot after input
    await binding.takeScreenshot('onboarding_input');
  });
}
