import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:google_fonts/google_fonts.dart';

/// Manages the application-wide theme configuration.
class AppTheme {
  /// Configuration for the light theme.
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      // Main brand color used for primary actions and highlights.
      primary: AppColors.primary,
      // Contrast color for text/icons placed on primary.
      onPrimary: Colors.white,
      // Main background color for the application surface.
      surface: Colors.white,
      // Main text color for content on the surface.
      onSurface: AppColors.textBlack,
      // used for card borders and subtle dividers.
      outline: Colors.grey.shade100,
      // used for card backgrounds and non-active selection states.
      surfaceContainerHighest: Colors.grey.shade50,
      // Secondary text color for less emphasis.
      onSurfaceVariant: Colors.grey.shade600,
      // used for critical alerts and error states.
      error: Colors.red.shade700,
      // used for error text on error background.
      onError: Colors.white,
      // Light background for error message blocks.
      errorContainer: Colors.red.shade50,
      // used for text inside error containers.
      onErrorContainer: Colors.red.shade900,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      // Material 2 compatibility - prefer using context.colorScheme.surface
      cardColor: colorScheme.surface,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
          ),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        color: colorScheme.surfaceContainerHighest,
      ),
    );
  }

  /// Configuration for the dark theme.
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      // Main brand color remains the same in dark mode for consistency.
      primary: AppColors.primary,
      // Contrast color for primary in dark mode.
      onPrimary: Colors.black,
      // Dark background for screens.
      surface: AppColors.cardGrey,
      // White text for readability in dark mode.
      onSurface: AppColors.textWhite,
      // Darker border color for containers.
      outline: AppColors.borderGrey,
      brightness: Brightness.dark,
      // used for card backgrounds in dark mode.
      surfaceContainerHighest: AppColors.cardGrey,
      // Subtle text for secondary info in dark mode.
      onSurfaceVariant: Colors.grey.shade400,
      // used for critical alerts in dark mode.
      error: Colors.red.shade400,
      // used for error text on error background.
      onError: Colors.black,
      // Dark background for error states.
      errorContainer: Colors.red.shade900.withValues(alpha: 0.2),
      // used for text inside error containers.
      onErrorContainer: Colors.red.shade200,
    );

    return ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      // Material 2 compatibility
      cardColor: colorScheme.surface,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.s20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
          ),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        color: colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
