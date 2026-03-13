import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glotist_app/core/di/injection_container.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_theme.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

/// A wrapper widget that provides the necessary context for previews.
/// This includes theming and localizations.
class PreviewWrapper extends StatelessWidget {
  /// Creates a [PreviewWrapper] instance.
  const PreviewWrapper({
    required this.child,
    super.key,
    this.locale = const Locale('en'),
    this.themeMode = ThemeMode.system,
  });

  /// The widget to be previewed.
  final Widget child;

  /// The locale to use for the preview.
  final Locale locale;

  /// The theme mode to use for the preview.
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    // Ensure dependencies are registered for previews if uninitialized.
    if (!sl.isRegistered<ChatRemoteDataSource>()) {
      sl.registerLazySingleton<ChatRemoteDataSource>(
        _MockChatRemoteDataSource.new,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
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
          BlocProvider<ThemeCubit>(
              create: (_) => _PreviewThemeCubit(themeMode),),
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
  _PreviewThemeCubit(super.initialState);

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

  @override
  List<LanguageModel> get displayLanguages => const [
        LanguageModel(
          code: 'en',
          nativeName: 'English',
          isoCode: 'us',
          isDisplay: true,
          isTarget: true,
        ),
        LanguageModel(
          code: 'es',
          nativeName: 'Español',
          isoCode: 'es',
          isDisplay: true,
          isTarget: true,
        ),
      ];

  @override
  List<LanguageModel> get targetLanguages => const [
        LanguageModel(
          code: 'en',
          nativeName: 'English',
          isoCode: 'us',
          isDisplay: true,
          isTarget: true,
        ),
        LanguageModel(
          code: 'es',
          nativeName: 'Español',
          isoCode: 'es',
          isDisplay: true,
          isTarget: true,
        ),
        LanguageModel(
          code: 'fr',
          nativeName: 'Français',
          isoCode: 'fr',
          isTarget: true,
        ),
        LanguageModel(
          code: 'de',
          nativeName: 'Deutsch',
          isoCode: 'de',
          isTarget: true,
        ),
      ];
}

class _MockChatRemoteDataSource implements ChatRemoteDataSource {
  @override
  Future<Message> sendMessage(String content) async {
    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: 'That sounds like a great hobby! I can definitely help you '
          'learn the vocabulary for that.',
      isUser: false,
      timestamp: DateTime.now(),
    );
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
  }) : super(wrapper: brightness == Brightness.dark ? _darkWrapper : _wrapper);

  /// The locale to use for the preview.
  final String locale;

  static Widget _wrapper(Widget child) => PreviewWrapper(child: child);
  static Widget _darkWrapper(Widget child) =>
      PreviewWrapper(themeMode: ThemeMode.dark, child: child);
}
