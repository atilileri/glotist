import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Theme 3-state toggle and persistence test', (tester) async {
    // 1. Initialize Shared Preferences mock
    SharedPreferences.setMockInitialValues({});

    // 3. Initialize dependency injection
    try {
      await di.init();
    } on Object catch (_) {
      // Ignore if already initialized
    }

    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();

    // Verify initial is System
    debugPrint('Initial theme: System');
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.system));

    // 2. Toggle to LIGHT
    debugPrint('Toggling to Light mode');
    final themeButton =
        find.bySemanticsLabel('Theme toggle'); // Top right toggle
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.light));

    // 3. Toggle to DARK
    debugPrint('Toggling to Dark mode');
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.dark));

    // 4. Persistence Test (Restart in Dark)
    debugPrint('Persistence test: Restarting in Dark mode');
    await tester.pumpWidget(const GlotistApp()); // Simulated restart
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.dark));

    // 5. Toggle to SYSTEM
    debugPrint('Toggling back to System mode');
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.system));

    // 6. Final Persistence Test (Restart in System)
    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.system));
  });

  testWidgets('Conversation screen renders in all theme modes', (tester) async {
    SharedPreferences.setMockInitialValues({});

    try {
      await di.init();
    } on Object catch (_) {
      // Ignore if already initialized
    }

    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();

    // Set theme to light (starts as system by default)
    final themeButton = find.bySemanticsLabel('Theme toggle');
    await tester.tap(themeButton);
    await tester.pumpAndSettle();

    // Navigate to conversation screen
    final continueButton = find.bySemanticsLabel('Continue to next step');
    await tester.tap(continueButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    debugPrint('Verifying conversation screen in Light mode');
    // Verify conversation screen renders without issues in light mode
    expect(find.text('Profile Setup'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Interests'), findsOneWidget);
    expect(find.text('Level'), findsOneWidget);
    expect(find.text('Purpose'), findsOneWidget);

    // Go back to language selection
    final backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Toggle theme to dark
    await tester.tap(themeButton);
    await tester.pumpAndSettle();

    // Navigate to conversation again
    await tester.tap(continueButton);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    debugPrint('Verifying conversation screen in Dark mode');
    // Verify conversation screen renders without issues in dark mode
    expect(find.text('Profile Setup'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Interests'), findsOneWidget);
    expect(find.text('Level'), findsOneWidget);
    expect(find.text('Purpose'), findsOneWidget);
  });
}
