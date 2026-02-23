/// Unit tests for [LocalizationCubit].
///
/// Tests cover:
/// - Initial state (English when no saved preference)
/// - Loading saved locale from SharedPreferences
/// - changeLocale updates state and persists
library;

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/data/repositories/language_repository.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  group('LocalizationCubit', () {
    late SharedPreferences prefs;

    setUp(() async {
      logSetup('Initializing LocalizationCubit tests');
    });

    tearDown(() {
      logTeardown('LocalizationCubit tests complete');
    });

    /// Test 1: Initial state is Locale('en') when no saved preference.
    ///
    /// Steps:
    /// 1. Create LocalizationCubit with empty SharedPreferences
    /// 2. Verify initial state is English locale
    testWidgets(
      '1. initial state is Locale("en") when no saved preference',
      (tester) async {
        logStep(1, 'Setting up empty SharedPreferences');
        prefs = await setupTestSharedPreferences();

        logStep(2, 'Creating LocalizationCubit');
        final cubit = LocalizationCubit(prefs, LanguageRepository());

        logVerify('Initial state should be Locale("en")');
        expect(cubit.state, const Locale('en'));

        await cubit.close();
      },
    );

    /// Test 2: Loads saved locale from SharedPreferences on init.
    ///
    /// Steps:
    /// 1. Pre-populate SharedPreferences with 'es' locale
    /// 2. Create LocalizationCubit
    /// 3. Wait for async load
    /// 4. Verify state is Spanish locale
    testWidgets(
      '2. loads saved Spanish locale from SharedPreferences on init',
      (tester) async {
        logStep(1, 'Pre-populating SharedPreferences with Spanish locale');
        prefs = await setupTestSharedPreferences({'app_locale': 'es'});

        logStep(2, 'Creating LocalizationCubit');
        final cubit = LocalizationCubit(prefs, LanguageRepository());
        await tester.pumpAndSettle();

        logVerify('State should be Locale("es")');
        expect(cubit.state, const Locale('es'));

        await cubit.close();
      },
    );

    /// Test 2.a: Loads saved Turkish locale from SharedPreferences on init.
    testWidgets(
      '2.a. loads saved Turkish locale from SharedPreferences on init',
      (tester) async {
        logStep(1, 'Pre-populating SharedPreferences with Turkish locale');
        prefs = await setupTestSharedPreferences({'app_locale': 'tr'});

        logStep(2, 'Creating LocalizationCubit');
        final cubit = LocalizationCubit(prefs, LanguageRepository());
        await tester.pumpAndSettle();

        logVerify('State should be Locale("tr")');
        expect(cubit.state, const Locale('tr'));

        await cubit.close();
      },
    );

    /// Test 2.b: Loads saved Dutch locale from SharedPreferences on init.
    testWidgets(
      '2.b. loads saved Dutch locale from SharedPreferences on init',
      (tester) async {
        logStep(1, 'Pre-populating SharedPreferences with Dutch locale');
        prefs = await setupTestSharedPreferences({'app_locale': 'nl'});

        logStep(2, 'Creating LocalizationCubit');
        final cubit = LocalizationCubit(prefs, LanguageRepository());
        await tester.pumpAndSettle();

        logVerify('State should be Locale("nl")');
        expect(cubit.state, const Locale('nl'));

        await cubit.close();
      },
    );

    /// Test 3: changeLocale updates state and persists to SharedPreferences.
    ///
    /// Steps:
    /// 1. Start with English
    /// 2. Change to German
    /// 3. Verify state changes
    /// 4. Verify SharedPreferences is updated
    testWidgets(
      '3. changeLocale updates state and persists to SharedPreferences',
      (tester) async {
        logStep(1, 'Setting up LocalizationCubit with English');
        prefs = await setupTestSharedPreferences();
        final cubit = LocalizationCubit(prefs, LanguageRepository());
        expect(cubit.state, const Locale('en'));

        logStep(2, 'Change locale to German');
        logAction('Calling changeLocale(Locale("de"))');
        await cubit.changeLocale('de');

        logStep(3, 'Verify state changed');
        expect(cubit.state, const Locale('de'));
        logVerify('State changed to Locale("de")');

        logStep(4, 'Verify persistence');
        await tester.pumpAndSettle();
        final savedLocale = prefs.getString('app_locale');
        logVerify('SharedPreferences should contain "de"');
        expect(savedLocale, 'de');

        await cubit.close();
      },
    );

    /// Test 4: Multiple locale changes work correctly.
    testWidgets(
      '4. multiple locale changes work correctly',
      (tester) async {
        logStep(1, 'Setting up LocalizationCubit');
        prefs = await setupTestSharedPreferences();
        final cubit = LocalizationCubit(prefs, LanguageRepository());

        logStep(2, 'Change locale multiple times');
        logAction('Changing locale: en → es → tr → nl');
        await cubit.changeLocale('es');
        expect(cubit.state, const Locale('es'));

        await cubit.changeLocale('tr');
        expect(cubit.state, const Locale('tr'));

        await cubit.changeLocale('nl');
        expect(cubit.state, const Locale('nl'));

        await tester.pumpAndSettle();

        logVerify('Final state should be Dutch');
        expect(cubit.state, const Locale('nl'));
        expect(prefs.getString('app_locale'), 'nl');

        await cubit.close();
      },
    );

    /// Test 5: Changing to same locale does not cause issues.
    testWidgets(
      '5. changing to same locale is idempotent',
      (tester) async {
        logStep(1, 'Setting up LocalizationCubit with Spanish');
        prefs = await setupTestSharedPreferences({'app_locale': 'es'});

        final cubit = LocalizationCubit(prefs, LanguageRepository());
        await tester.pumpAndSettle();
        expect(cubit.state, const Locale('es'));

        logStep(2, 'Change to same locale');
        logAction('Calling changeLocale(Locale("es")) again');
        await cubit.changeLocale('es');

        logVerify('State should still be Spanish');
        expect(cubit.state, const Locale('es'));

        await cubit.close();
      },
    );
  });
}
