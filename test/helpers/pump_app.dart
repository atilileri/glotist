/// Extension on WidgetTester for consistent widget pumping with providers.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_theme.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

/// Extension methods on [WidgetTester] for pumping widgets with providers.
extension PumpApp on WidgetTester {
  /// Pumps a widget wrapped with all necessary providers and MaterialApp.
  ///
  /// This provides a consistent test environment with:
  /// - ThemeCubit for theme management
  /// - LocalizationCubit for localization
  /// - Proper localization delegates
  ///
  /// Example:
  /// ```dart
  /// await tester.pumpApp(
  ///   const MyWidget(),
  ///   themeCubit: mockThemeCubit,
  ///   localizationCubit: mockLocalizationCubit,
  /// );
  /// ```
  Future<void> pumpApp(
    Widget widget, {
    ThemeCubit? themeCubit,
    LocalizationCubit? localizationCubit,
    ThemeMode? themeMode,
    Locale? locale,
    NavigatorObserver? navigatorObserver,
  }) async {
    final effectiveThemeMode =
        themeMode ?? themeCubit?.state ?? ThemeMode.system;
    final effectiveLocale =
        locale ?? localizationCubit?.state ?? const Locale('en');

    await pumpWidget(
      MultiBlocProvider(
        providers: [
          if (themeCubit != null)
            BlocProvider<ThemeCubit>.value(value: themeCubit)
          else
            BlocProvider<ThemeCubit>(
              create: (_) => _FakeThemeCubit(effectiveThemeMode),
            ),
          if (localizationCubit != null)
            BlocProvider<LocalizationCubit>.value(value: localizationCubit)
          else
            BlocProvider<LocalizationCubit>(
              create: (_) => _FakeLocalizationCubit(effectiveLocale),
            ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: effectiveThemeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          locale: effectiveLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorObservers: [
            if (navigatorObserver != null) navigatorObserver,
          ],
          home: widget,
        ),
      ),
    );

    // Allow the widget tree to settle
    await pumpAndSettle();
  }

  /// Pumps a widget with minimal setup (no cubits, basic MaterialApp).
  ///
  /// Useful for testing widgets that don't depend on cubits.
  Future<void> pumpWidgetSimple(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
    await pumpAndSettle();
  }
}

/// Fake ThemeCubit for testing without SharedPreferences.
class _FakeThemeCubit extends Cubit<ThemeMode> implements ThemeCubit {
  _FakeThemeCubit(super.initialState);

  @override
  Future<void> toggleTheme() async {
    switch (state) {
      case ThemeMode.system:
        emit(ThemeMode.light);
      case ThemeMode.light:
        emit(ThemeMode.dark);
      case ThemeMode.dark:
        emit(ThemeMode.system);
    }
  }

  @override
  Future<void> setTheme(ThemeMode mode) async => emit(mode);
}

/// Fake LocalizationCubit for testing without SharedPreferences.
class _FakeLocalizationCubit extends Cubit<Locale>
    implements LocalizationCubit {
  _FakeLocalizationCubit(super.initialState);

  @override
  Future<void> changeLocale(String languageCode) async =>
      emit(Locale(languageCode));

  @override
  List<LanguageModel> get displayLanguages => [];

  @override
  List<LanguageModel> get targetLanguages => [];
}
