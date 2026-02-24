import 'package:glotist_app/core/models/language_model.dart';

/// Repository for providing language data.
class LanguageRepository {
  /// Returns a list of all supported languages in the application.
  List<LanguageModel> getLanguages() {
    return const [
      LanguageModel(
        code: 'en',
        nativeName: 'English (United States)',
        isoCode: 'us',
        isDisplay: true,
      ),
      LanguageModel(
        code: 'es',
        nativeName: 'Español',
        isoCode: 'es',
        isDisplay: true,
      ),
      LanguageModel(
        code: 'fr',
        nativeName: 'Français',
        isoCode: 'fr',
        isDisplay: true,
      ),
      LanguageModel(
        code: 'tr',
        nativeName: 'Türkçe',
        isoCode: 'tr',
        isDisplay: true,
        isTarget: true,
      ),
      LanguageModel(
        code: 'de',
        nativeName: 'Deutsch',
        isoCode: 'de',
        isDisplay: true,
      ),
      LanguageModel(
        code: 'nl',
        nativeName: 'Nederlands',
        isoCode: 'nl',
        isDisplay: true,
        isTarget: true,
      ),
      LanguageModel(
        code: 'jp',
        nativeName: '日本語',
        isoCode: 'jp',
        isTarget: true,
      ),
      LanguageModel(
        code: 'it',
        nativeName: 'Italiano',
        isoCode: 'it',
        isTarget: true,
      ),
      LanguageModel(
        code: 'pt',
        nativeName: 'Português',
        isoCode: 'pt',
        isTarget: true,
      ),
      LanguageModel(
        code: 'kr',
        nativeName: '한국어',
        isoCode: 'kr',
        isTarget: true,
      ),
    ];
  }
}
