import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/theme/app_theme.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

/// A wrapper widget that provides the necessary context for previews.
/// This includes theming and localizations.
class PreviewWrapper extends StatelessWidget {
  /// Creates a [PreviewWrapper] instance.
  const PreviewWrapper({
    required this.child,
    super.key,
    this.locale = const Locale('en'),
    this.brightness = Brightness.light,
  });

  /// The widget to be previewed.
  final Widget child;

  /// The locale to use for the preview.
  final Locale locale;

  /// The brightness to use for the preview.
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (_) => _PreviewThemeCubit()),
          BlocProvider<LocalizationCubit>(
            create: (_) => _PreviewLocalizationCubit(),
          ),
        ],
        child: Scaffold(body: child),
      ),
    );
  }
}

class _PreviewThemeCubit extends Cubit<ThemeMode> implements ThemeCubit {
  _PreviewThemeCubit() : super(ThemeMode.system);

  @override
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

    emit(next);
  }

  @override
  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
  }
}

class _PreviewLocalizationCubit extends Cubit<Locale>
    implements LocalizationCubit {
  _PreviewLocalizationCubit() : super(const Locale('en'));

  @override
  Future<void> changeLocale(String languageCode) async {
    emit(Locale(languageCode));
  }
}

/// A custom preview annotation for the Glotist app.
final class AppPreview extends Preview {
  /// Creates an [AppPreview] instance.
  const AppPreview({
    super.name,
    super.group,
    super.size,
    super.textScaleFactor,
    super.brightness,
    this.locale = 'en',
  }) : super(wrapper: _wrapperBuilder);

  /// The locale to use for the preview.
  final String locale;

  static Widget _wrapperBuilder(Widget child) {
    // In a real implementation, we would extract the brightness and locale
    // from the Preview instance if possible, but the wrapper function
    // only receives the child.
    // For now, we use a default wrapper.
    return PreviewWrapper(child: child);
  }
}
