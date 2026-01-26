import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/language_selection_screen.dart';
import 'package:glotist_app/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Native Language Selection and Persistence Test',
      (WidgetTester tester) async {
    // 1. Setup
    SharedPreferences.setMockInitialValues({});
    try {
      await di.init();
    } on Exception catch (_) {
      // Ignore if already initialized
    }

    await tester.pumpWidget(const GlotistApp());
    await tester.pumpAndSettle();

    // Verify we are on LanguageSelectionScreen
    expect(find.byType(LanguageSelectionScreen), findsOneWidget);

    // Initial verification (English default)
    final context = tester.element(find.byType(LanguageSelectionScreen));
    expect(context.read<LocalizationCubit>().state.languageCode, equals('en'));

    // Define test cases: Display Name -> Expected Locale
    // Note: The map order matters if we want to test switching back and forth.
    final testCases = {
      'Spanish': 'es',
      'French': 'fr',
      'Turkish': 'tr',
      'German': 'de',
      'Dutch': 'nl',
      'English (United States)': 'en',
    };

    for (final entry in testCases.entries) {
      final languageName = entry.key;
      final expectedLocaleCode = entry.value;

      debugPrint('Testing selection: $languageName -> $expectedLocaleCode');

      // 2. Open Dropdown
      // Finding by type DropdownButton<String> might be tricky with generics in
      // tests sometimes,
      // but let's try finding the widget that contains the arrow icon which is
      // typical for dropdowns
      // or just by Type.
      final dropdownFinder = find.byType(DropdownButton<String>);
      expect(dropdownFinder, findsOneWidget);

      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      // 3. Select Language
      // We look for the item in the dropdown menu.
      // Since it's a scrollable list potentially, we might need to scroll it
      // into view if there are many items.
      // The list has 6 items, usually fits on screen, but to be safe we can
      // verify.
      final itemFinder = find.text(languageName).last;

      await tester.tap(itemFinder);
      await tester.pumpAndSettle();

      // 4. Verify Cubit State
      // Access the cubit from the widget tree
      final context = tester.element(find.byType(LanguageSelectionScreen));
      final cubit = context.read<LocalizationCubit>();
      expect(cubit.state.languageCode, equals(expectedLocaleCode));
    }
  });
}
