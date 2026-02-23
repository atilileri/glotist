import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/language_selection_screen.dart';
import 'package:glotist_app/l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}

class MockLocalizationCubit extends MockCubit<Locale>
    implements LocalizationCubit {}

void main() {
  late MockThemeCubit mockThemeCubit;
  late MockLocalizationCubit mockLocalizationCubit;

  setUp(() {
    mockThemeCubit = MockThemeCubit();
    mockLocalizationCubit = MockLocalizationCubit();

    when(() => mockThemeCubit.state).thenReturn(ThemeMode.system);
    when(() => mockLocalizationCubit.state).thenReturn(const Locale('en'));
    when(() => mockLocalizationCubit.stream)
        .thenAnswer((_) => const Stream.empty());

    final dummyLanguages = [
      const LanguageModel(
        code: 'en',
        nativeName: 'English (United States)',
        isoCode: 'us',
      ),
      const LanguageModel(code: 'es', nativeName: 'Español', isoCode: 'es'),
      const LanguageModel(code: 'jp', nativeName: 'Japanese', isoCode: 'jp'),
      const LanguageModel(code: 'it', nativeName: 'Italiano', isoCode: 'it'),
    ];
    when(() => mockLocalizationCubit.displayLanguages)
        .thenReturn(dummyLanguages);
    when(() => mockLocalizationCubit.targetLanguages)
        .thenReturn(dummyLanguages);
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: mockThemeCubit),
        BlocProvider<LocalizationCubit>.value(value: mockLocalizationCubit),
      ],
      child: const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('es'),
          Locale('fr'),
          Locale('tr'),
          Locale('de'),
          Locale('nl'),
        ],
        locale: Locale('en'),
        home: LanguageSelectionScreen(),
      ),
    );
  }

  group('LanguageSelectionScreen', () {
    testWidgets('renders all key UI elements', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      logVerify('Should render theme toggle');
      expect(find.bySemanticsLabel('Theme toggle'), findsOneWidget);

      logVerify('Should render display language dropdown');
      expect(
        find.byKey(const Key('display_language_dropdown')),
        findsOneWidget,
      );
      // TODO(agent): why this changed from findsOneWidget to findsWidgets?
      expect(find.text('English (United States)'), findsWidgets);

      logVerify('Should render language grid items');
      // Japanese is default selected in code: String _targetLanguage = 'jp';
      expect(
        find.bySemanticsLabel(RegExp('.*Japanese.*selected.*')),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel(RegExp('.*Italian.*')), findsOneWidget);

      logVerify('Should render Continue button');
      expect(find.bySemanticsLabel('Continue to next step'), findsOneWidget);
    });

    testWidgets('toggling theme calls ThemeCubit.toggleTheme', (tester) async {
      when(() => mockThemeCubit.toggleTheme()).thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      logAction('Tapping theme toggle');
      await tester.tap(find.bySemanticsLabel('Theme toggle'));
      await tester.pump();

      verify(() => mockThemeCubit.toggleTheme()).called(1);
    });

    testWidgets(
        'changing display language calls LocalizationCubit.changeLocale',
        (tester) async {
      when(() => mockLocalizationCubit.changeLocale(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      logAction('Opening dropdown');
      // Find the dropdown by its key
      final dropdownFinder = find.byKey(const Key('display_language_dropdown'));
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      logAction('Selecting Spanish');
      final spanishOption = find
          .text('Español')
          .last; // last because one might be in the list behind
      await tester.tap(spanishOption);
      await tester.pump();

      verify(() => mockLocalizationCubit.changeLocale('es')).called(1);
    });

    testWidgets('selecting a target language updates visual selection',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Use RegExp for more robust matching of semantic labels
      Finder bySemantics(String label) {
        return find.byWidgetPredicate(
          (widget) => widget is Semantics && widget.properties.label == label,
          skipOffstage: false,
        );
      }

      Finder bySemanticsPattern(RegExp pattern) {
        return find.byWidgetPredicate(
          (widget) =>
              widget is Semantics &&
              widget.properties.label != null &&
              pattern.hasMatch(widget.properties.label!),
          skipOffstage: false,
        );
      }

      // Initial state: Japanese selected
      logVerify('Japanese should be selected initially');
      expect(bySemantics('Japanese language option, selected'), findsOneWidget);
      expect(bySemantics('Italian language option'), findsOneWidget);

      logAction('Tapping Italian');
      final italianFinder = bySemantics('Italian language option');
      await tester.ensureVisible(italianFinder);
      // Scroll up to ensure it's not covered by the bottom navigation bar
      await tester.drag(find.byType(ListView), const Offset(0, -150));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Italiano'));
      await tester.pumpAndSettle();

      logVerify('Italian should now be selected');

      // Verify Japanese is deselected first to narrow down failure
      if (tester.any(bySemantics('Japanese language option, selected'))) {
        fail('Tap failed: Japanese is still selected after tapping Italian');
      }

      // "Italian language option, selected" - we expect this label now
      // Re-constructing the expected string or using pattern
      expect(
        bySemanticsPattern(RegExp('.*Italian.*selected.*')),
        findsOneWidget,
      );

      logVerify('Japanese should NOT be selected');
      expect(bySemantics('Japanese language option'), findsOneWidget);
      expect(bySemantics('Japanese language option, selected'), findsNothing);
    });
  });
}
