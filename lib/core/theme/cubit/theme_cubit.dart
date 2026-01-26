import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit for managing the application's theme mode.
class ThemeCubit extends Cubit<ThemeMode> {
  /// Creates a [ThemeCubit] instance.
  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  final SharedPreferences _prefs;
  static const _themeKey = 'theme_mode';

  void _loadTheme() {
    final themeIndex = _prefs.getInt(_themeKey);
    if (themeIndex != null) {
      emit(ThemeMode.values[themeIndex]);
    }
  }

  /// Toggles the current theme between light and dark.
  Future<void> toggleTheme() async {
    final current = state;
    final next = current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _prefs.setInt(_themeKey, next.index);
    emit(next);
  }

  /// Sets the theme to a specific [mode].
  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.setInt(_themeKey, mode.index);
    emit(mode);
  }
}
