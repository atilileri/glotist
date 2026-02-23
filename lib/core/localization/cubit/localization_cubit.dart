import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:glotist_app/core/data/repositories/language_repository.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit for managing the application's locale.
class LocalizationCubit extends Cubit<Locale> {
  /// Creates a [LocalizationCubit] instance.
  LocalizationCubit(this._prefs, this._languageRepository)
      : super(const Locale('en')) {
    _loadLocale();
  }

  final SharedPreferences _prefs;
  final LanguageRepository _languageRepository;
  static const _localeKey = 'app_locale';

  void _loadLocale() {
    final languageCode = _prefs.getString(_localeKey);
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  /// Changes the current locale to the provided [languageCode].
  Future<void> changeLocale(String languageCode) async {
    await _prefs.setString(_localeKey, languageCode);
    emit(Locale(languageCode));
  }

  /// Returns the languages available for the app interface.
  List<LanguageModel> get displayLanguages {
    final all = _languageRepository.getLanguages();
    // TODO(agent): define a logic inside language_repository and
    // remove this list. Same for targetLanguages
    const displayCodes = ['en', 'es', 'fr', 'tr', 'de', 'nl'];
    return all.where((l) => displayCodes.contains(l.code)).toList();
  }

  /// Returns the languages available to learn.
  List<LanguageModel> get targetLanguages {
    final all = _languageRepository.getLanguages();
    const targetCodes = ['jp', 'it', 'pt', 'kr', 'tr', 'nl'];
    return all.where((l) => targetCodes.contains(l.code)).toList();
  }
}
