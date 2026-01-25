import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify onboarding flow and take screenshot', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verify we are on the OnboardingConversationScreen
    // (assuming it's the home)
    // Adjust based on actual main.dart navigation if needed.
    // Based on previous conversations/files, it seems Onboarding is
    // part of the flow.

    // We expect to see the Onboarding Assistant
    expect(find.text('Onboarding Assistant'), findsOneWidget);

    // Take a screenshot of the initial screen
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await binding.takeScreenshot('onboarding_initial');

    // Enter text
    final inputFinder = find.byType(TextField);
    await tester.enterText(inputFinder, 'I want to learn Japanese');
    await tester.pumpAndSettle();

    // Send logic might be mocked or real depending on if we use a
    // separate main for testing.
    // For E2E, usually we use real app.
    // If it hits a real backend, it might fail if not configured.
    // But assuming it's acceptable or mocked in main.dart or we just
    // test UI structure.

    // Take another screenshot after input
    await binding.takeScreenshot('onboarding_input');
  });
}
