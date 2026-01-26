import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Manages the application-wide theme configuration.
class AppTheme {
  /// Configuration for the light theme.
  /// Configuration for the light theme.
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: Colors.white,
        onSurface: AppColors.textBlack,
        outline: AppColors.borderGrey,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    );
  }

  /// Configuration for the dark theme.
  static ThemeData get darkTheme {
    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardGrey,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.cardGrey,
        onSurface: AppColors.textWhite,
        outline: AppColors.borderGrey,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ),
    );
  }
}
