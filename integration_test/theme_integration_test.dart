import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/main.dart'; // Imports main to access dependencies
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Theme 3-state toggle and persistence test',
      (WidgetTester tester) async {
    // 1. Start App (Clean State)
    SharedPreferences.setMockInitialValues({});
    await di.init();

    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();

    // Verify initial is System
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.system));

    // 2. Toggle to LIGHT
    final themeButton = find.byType(IconButton).last; // Top right toggle
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.light));

    // 3. Toggle to DARK
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.dark));

    // 4. Persistence Test (Restart in Dark)
    await tester.pumpWidget(const GlotistApp()); // Simulated restart
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.dark));

    // 5. Toggle to SYSTEM
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.system));

    // 6. Final Persistence Test (Restart in System)
    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();
    expect(di.sl<ThemeCubit>().state, equals(ThemeMode.system));
  });
}
