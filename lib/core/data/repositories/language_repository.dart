import 'package:glotist_app/core/models/language_model.dart';

/// Repository for providing language data.
class LanguageRepository {
  /// Returns a list of all supported languages in the application.
  List<LanguageModel> getLanguages() {
    return const [
      // Display & Target languages
      LanguageModel(
        code: 'en',
        nativeName: 'English (United States)',
        isoCode: 'us',
      ),
      LanguageModel(code: 'es', nativeName: 'Español', isoCode: 'es'),
      LanguageModel(code: 'fr', nativeName: 'Français', isoCode: 'fr'),
      LanguageModel(code: 'tr', nativeName: 'Türkçe', isoCode: 'tr'),
      LanguageModel(code: 'de', nativeName: 'Deutsch', isoCode: 'de'),
      LanguageModel(code: 'nl', nativeName: 'Nederlands', isoCode: 'nl'),

      // Target languages only (currently)
      LanguageModel(code: 'jp', nativeName: '日本語', isoCode: 'jp'),
      LanguageModel(code: 'it', nativeName: 'Italiano', isoCode: 'it'),
      LanguageModel(code: 'pt', nativeName: 'Português', isoCode: 'pt'),
      LanguageModel(code: 'kr', nativeName: '한국어', isoCode: 'kr'),
    ];
  }
}
