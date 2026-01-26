import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/main.dart'; // Imports main to access dependencies
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Theme toggle and persistence test', (WidgetTester tester) async {
    // 1. Start App
    SharedPreferences.setMockInitialValues({});
    await di.init();

    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();

    // 2. Determine Current Brightness
    var currentContext = tester.element(find.byType(MaterialApp));
    final initialTheme = Theme.of(currentContext);
    final initialBrightness = initialTheme.brightness;

    debugPrint('Initial Brightness: $initialBrightness');

    // 3. Find Theme Switch Button
    final themeButton = find.byIcon(
      initialBrightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode,
    );

    if (themeButton.evaluate().isEmpty) {
      // Fallback
    }

    // 4. Toggle to Opposite
    debugPrint('Tapping theme button...');
    await tester.tap(themeButton);
    await tester.pump(); // Start animation
    await tester.pump(const Duration(seconds: 1)); // Wait for animation
    await tester.pumpAndSettle();

    currentContext = tester.element(find.byType(MaterialApp));
    final newTheme = Theme.of(currentContext);
    final newBrightness = newTheme.brightness;

    debugPrint('New Brightness: $newBrightness');

    // Verify it changed
    expect(newBrightness, isNot(equals(initialBrightness)));

    // 5. Restart (Simulate)
    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();

    final restartedContext = tester.element(find.byType(MaterialApp));
    final restartedBrightness = Theme.of(restartedContext).brightness;

    debugPrint('Restarted Brightness: $restartedBrightness');

    // 6. Verify Brightness Persisted
    expect(restartedBrightness, equals(newBrightness));
  });
}
