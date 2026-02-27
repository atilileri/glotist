import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

void main() {
  group('AppLocalizations', () {
    test('supportedLocales contains all expected locales', () {
      expect(
        AppLocalizations.supportedLocales,
        containsAll([
          const Locale('de'),
          const Locale('en'),
          const Locale('es'),
          const Locale('fr'),
          const Locale('nl'),
          const Locale('tr'),
        ]),
      );
    });

    group('English translations', () {
      test('matches exact strings for en', () async {
        final localizations =
            await AppLocalizations.delegate.load(const Locale('en'));

        expect(localizations.appTitle, 'Glotist');
        expect(localizations.languageSelectionTitle, 'Languages');
        expect(localizations.letsGetStarted, "Let's get started");
        expect(
          localizations.refineExperience,
          'Refine your language learning experience',
        );
        expect(localizations.displayLanguage, 'DISPLAY LANGUAGE');
        expect(
          localizations.displayLanguageDisclaimer,
          'Will be used for interface and conversations',
        );
        expect(localizations.languageToLearn, 'LANGUAGE TO LEARN');
        expect(localizations.seeAllLanguages, 'See all 40+ languages');
        expect(localizations.continueAction, 'Continue');

        // Language names
        expect(localizations.langEnglish, 'English');
        expect(localizations.langEnglishUS, 'English (United States)');
        expect(localizations.langSpanish, 'Spanish');
        expect(localizations.langFrench, 'French');
        expect(localizations.langTurkish, 'Turkish');
        expect(localizations.langGerman, 'German');
        expect(localizations.langDutch, 'Dutch');
        expect(localizations.langJapanese, 'Japanese');
        expect(localizations.langItalian, 'Italian');
        expect(localizations.langPortuguese, 'Portuguese');
        expect(localizations.langKorean, 'Korean');
      });
    });

    group('Other supported locales', () {
      for (final locale in AppLocalizations.supportedLocales) {
        if (locale.languageCode == 'en') continue;

        test('''
lookupAppLocalizations works and returns non-empty strings for ${locale.languageCode}''',
            () {
          final localizations = lookupAppLocalizations(locale);
          expect(localizations, isNotNull);

          // Access all getters to hit coverage and ensure no null/empty strings
          // Note: Since these are generated, checking for non-empty is a good
          // baseline integration check that the generating tool worked
          // properly.
          expect(localizations.appTitle, isNotEmpty);
          expect(localizations.languageSelectionTitle, isNotEmpty);
          expect(localizations.letsGetStarted, isNotEmpty);
          expect(localizations.refineExperience, isNotEmpty);
          expect(localizations.displayLanguage, isNotEmpty);
          expect(localizations.displayLanguageDisclaimer, isNotEmpty);
          expect(localizations.languageToLearn, isNotEmpty);
          expect(localizations.seeAllLanguages, isNotEmpty);
          expect(localizations.continueAction, isNotEmpty);
          expect(localizations.langEnglish, isNotEmpty);
          expect(localizations.langEnglishUS, isNotEmpty);
          expect(localizations.langSpanish, isNotEmpty);
          expect(localizations.langFrench, isNotEmpty);
          expect(localizations.langTurkish, isNotEmpty);
          expect(localizations.langGerman, isNotEmpty);
          expect(localizations.langDutch, isNotEmpty);
          expect(localizations.langJapanese, isNotEmpty);
          expect(localizations.langItalian, isNotEmpty);
          expect(localizations.langPortuguese, isNotEmpty);
          expect(localizations.langKorean, isNotEmpty);
        });
      }
    });

    test('lookupAppLocalizations throws on unsupported locale', () {
      expect(
        () => lookupAppLocalizations(const Locale('it')),
        throwsA(isA<FlutterError>()),
      );
    });

    test('delegate properties are correct', () async {
      const delegate = AppLocalizations.delegate;

      expect(delegate.isSupported(const Locale('en')), isTrue);
      // 'it' is not a supported locale
      expect(delegate.isSupported(const Locale('it')), isFalse);

      // Should not reload
      expect(delegate.shouldReload(delegate), isFalse);

      final loaded = await delegate.load(const Locale('en'));
      expect(loaded, isNotNull);
      expect(loaded.localeName, equals('en'));
    });
  });
}
