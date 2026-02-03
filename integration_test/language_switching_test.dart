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

  testWidgets('Display Language Selection and Persistence Test',
      (tester) async {
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
      'Español': 'es',
      'Français': 'fr',
      'Türkçe': 'tr',
      'Deutsch': 'de',
      'Nederlands': 'nl',
      'English (United States)': 'en',
    };

    for (final entry in testCases.entries) {
      final languageName = entry.key;
      final expectedLocaleCode = entry.value;

      debugPrint('Testing selection: $languageName -> $expectedLocaleCode');

      // 2. Open Dropdown using Semantic Label
      final dropdownFinder = find.byKey(const Key('display_language_dropdown'));
      expect(dropdownFinder, findsOneWidget);

      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();
      // Dropdown menus sometimes take an extra pump to be fully tappable in
      // integration tests
      await tester.pump(const Duration(seconds: 1));

      // 3. Select Language
      // Debug: print all text widgets if we can't find the item
      final items = find.text(languageName);
      if (items.evaluate().isEmpty) {
        debugPrint('ERROR: Could not find language item: $languageName');
        debugPrint('Available text widgets:');
        for (final element in find.byType(Text).evaluate()) {
          final textWidget = element.widget as Text;
          debugPrint('  - ${textWidget.data}');
        }
      }

      final itemFinder = items.last;
      await tester.tap(itemFinder);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      // 4. Verify Cubit State
      final context = tester.element(find.byType(LanguageSelectionScreen));
      final cubit = context.read<LocalizationCubit>();
      expect(cubit.state.languageCode, equals(expectedLocaleCode));
    }
  });
}
