import 'package:flutter/material.dart';
import 'package:glotist_app/core/di/injection_container.dart' as di;
import 'package:glotist_app/core/router/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1DE9B6),
          primary: const Color(0xFF1DE9B6),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1DE9B6),
          primary: const Color(0xFF1DE9B6),
          brightness: Brightness.dark,
        ),
        textTheme:
            GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),
      ),
      routerConfig: router,
    );
  }
}
