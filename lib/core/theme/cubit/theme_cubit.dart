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

  /// Toggles the current theme between system, light, and dark.
  Future<void> toggleTheme() async {
    final current = state;
    ThemeMode next;

    switch (current) {
      case ThemeMode.system:
        next = ThemeMode.light;
      case ThemeMode.light:
        next = ThemeMode.dark;
      case ThemeMode.dark:
        next = ThemeMode.system;
    }

    await _prefs.setInt(_themeKey, next.index);
    emit(next);
  }

  /// Sets the theme to a specific [mode].
  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.setInt(_themeKey, mode.index);
    emit(mode);
  }
}
