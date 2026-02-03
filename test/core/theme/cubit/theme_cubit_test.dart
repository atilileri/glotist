/// Unit tests for [ThemeCubit].
///
/// Tests cover:
/// - Initial state (system theme when no saved preference)
/// - Loading saved theme from SharedPreferences
/// - Toggle cycling: system → light → dark → system
/// - Direct theme setting with persistence
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  group('ThemeCubit', () {
    late SharedPreferences prefs;

    setUp(() async {
      logSetup('Initializing ThemeCubit tests');
    });

    tearDown(() {
      logTeardown('ThemeCubit tests complete');
    });

    /// Test 1: Initial state is ThemeMode.system when no saved preference.
    ///
    /// Steps:
    /// 1. Create ThemeCubit with empty SharedPreferences
    /// 2. Verify initial state is ThemeMode.system
    testWidgets(
      '1. initial state is ThemeMode.system when no saved preference',
      (tester) async {
        logStep(1, 'Setting up empty SharedPreferences');
        prefs = await setupTestSharedPreferences();

        logStep(2, 'Creating ThemeCubit');
        final cubit = ThemeCubit(prefs);

        logVerify('Initial state should be ThemeMode.system');
        expect(cubit.state, ThemeMode.system);

        await cubit.close();
      },
    );

    /// Test 1.a: Loads saved light theme from SharedPreferences on init.
    ///
    /// Steps:
    /// 1. Pre-populate SharedPreferences with 'light' theme
    /// 2. Create ThemeCubit
    /// 3. Wait for async load
    /// 4. Verify state is ThemeMode.light
    testWidgets(
      '1.a. loads saved light theme from SharedPreferences on init',
      (tester) async {
        logStep(1, 'Pre-populating SharedPreferences with light theme');
        prefs = await setupTestSharedPreferences({
          'theme_mode': ThemeMode.light.index,
        });

        logStep(2, 'Creating ThemeCubit');
        final cubit = ThemeCubit(prefs);

        // Wait for async _loadTheme to complete
        await tester.pumpAndSettle();

        logVerify('State should be ThemeMode.light');
        expect(cubit.state, ThemeMode.light);

        await cubit.close();
      },
    );

    /// Test 1.b: Loads saved dark theme from SharedPreferences on init.
    testWidgets(
      '1.b. loads saved dark theme from SharedPreferences on init',
      (tester) async {
        logStep(1, 'Pre-populating SharedPreferences with dark theme');
        prefs = await setupTestSharedPreferences({
          'theme_mode': ThemeMode.dark.index,
        });

        logStep(2, 'Creating ThemeCubit');
        final cubit = ThemeCubit(prefs);
        await tester.pumpAndSettle();

        logVerify('State should be ThemeMode.dark');
        expect(cubit.state, ThemeMode.dark);

        await cubit.close();
      },
    );

    /// Test 1.c: Loads saved system theme from SharedPreferences on init.
    testWidgets(
      '1.c. loads saved system theme from SharedPreferences on init',
      (tester) async {
        logStep(1, 'Pre-populating SharedPreferences with system theme');
        prefs = await setupTestSharedPreferences({
          'theme_mode': ThemeMode.system.index,
        });

        logStep(2, 'Creating ThemeCubit');
        final cubit = ThemeCubit(prefs);
        await tester.pumpAndSettle();

        logVerify('State should be ThemeMode.system');
        expect(cubit.state, ThemeMode.system);

        await cubit.close();
      },
    );

    /// Test 2: toggleTheme cycles system → light → dark → system.
    ///
    /// Steps:
    /// 1. Start with system theme
    /// 2. Toggle → light
    /// 3. Toggle → dark
    /// 4. Toggle → system
    testWidgets(
      '2. toggleTheme cycles system → light → dark → system',
      (tester) async {
        logStep(1, 'Setting up ThemeCubit with system theme');
        prefs = await setupTestSharedPreferences();
        final cubit = ThemeCubit(prefs);
        expect(cubit.state, ThemeMode.system);

        logStep(2, 'Toggle to light');
        logAction('Calling toggleTheme()');
        await cubit.toggleTheme();
        expect(cubit.state, ThemeMode.light);
        logVerify('State changed to ThemeMode.light');

        logStep(3, 'Toggle to dark');
        logAction('Calling toggleTheme()');
        await cubit.toggleTheme();
        expect(cubit.state, ThemeMode.dark);
        logVerify('State changed to ThemeMode.dark');

        logStep(4, 'Toggle back to system');
        logAction('Calling toggleTheme()');
        await cubit.toggleTheme();
        expect(cubit.state, ThemeMode.system);
        logVerify('State changed back to ThemeMode.system');

        await cubit.close();
      },
    );

    /// Test 3: setTheme sets specific mode and persists.
    ///
    /// Steps:
    /// 1. Set theme to dark directly
    /// 2. Verify state changes
    /// 3. Verify SharedPreferences is updated
    testWidgets(
      '3. setTheme sets specific mode and persists to SharedPreferences',
      (tester) async {
        logStep(1, 'Setting up ThemeCubit');
        prefs = await setupTestSharedPreferences();
        final cubit = ThemeCubit(prefs);

        logStep(2, 'Set theme to dark');
        logAction('Calling setTheme(ThemeMode.dark)');
        await cubit.setTheme(ThemeMode.dark);
        expect(cubit.state, ThemeMode.dark);

        logStep(3, 'Verify persistence');
        await tester.pumpAndSettle();
        final savedTheme = prefs.getString('theme');
        logVerify('SharedPreferences should contain "dark"');
        expect(savedTheme, 'dark');

        await cubit.close();
      },
    );

    /// Test 4: Multiple setTheme calls only persist the last value.
    testWidgets(
      '4. rapid setTheme calls persist correctly',
      (tester) async {
        logStep(1, 'Setting up ThemeCubit');
        prefs = await setupTestSharedPreferences();
        final cubit = ThemeCubit(prefs);

        logStep(2, 'Rapid theme changes');
        logAction('Calling setTheme multiple times');
        await cubit.setTheme(ThemeMode.light);
        await cubit.setTheme(ThemeMode.dark);
        await cubit.setTheme(ThemeMode.light);

        await tester.pumpAndSettle();

        logVerify('Final state should be light');
        expect(cubit.state, ThemeMode.light);
        expect(prefs.getString('theme'), 'light');

        await cubit.close();
      },
    );
  });
}
