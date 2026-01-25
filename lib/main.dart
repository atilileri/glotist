import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/core/router/app_router.dart';
import 'package:glotist_app/core/theme/app_theme.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const GlotistApp());
}

/// Main entry point for the Glotist application.
class GlotistApp extends StatelessWidget {
  /// Creates a [GlotistApp] instance.
  const GlotistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Glotist',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
