import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/router/app_router.dart';
import 'package:glotist_app/core/theme/app_theme.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await di.init();
  runApp(const GlotistApp());
}

/// Main entry point for the Glotist application.
class GlotistApp extends StatelessWidget {
  /// Creates a [GlotistApp] instance.
  const GlotistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ThemeCubit>()),
        BlocProvider(create: (context) => di.sl<LocalizationCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocalizationCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: 'Glotist',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                locale: locale,
                routerConfig: router,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
