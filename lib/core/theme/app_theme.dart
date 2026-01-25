import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Manages the application-wide theme configuration.
class AppTheme {
  /// Configuration for the light theme.
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      useMaterial3: true,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    );
  }

  /// Configuration for the dark theme.
  static ThemeData get darkTheme {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ),
    );
  }
}
