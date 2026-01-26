import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit for managing the application's locale.
class LocalizationCubit extends Cubit<Locale> {
  /// Creates a [LocalizationCubit] instance.
  LocalizationCubit(this._prefs) : super(const Locale('en')) {
    _loadLocale();
  }

  final SharedPreferences _prefs;
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
}
