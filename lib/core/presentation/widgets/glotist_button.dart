import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';

/// A beautifully styled, universal button for the Glotist application.
///
/// This component abstracts away inline styling and enforces the
/// primary/secondary design system for call-to-action buttons.
class GlotistButton extends StatelessWidget {
  /// Creates a [GlotistButton] instance.
  const GlotistButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.icon,
    this.isPrimary = true,
  });

  /// Callback when the button is tapped. If null, the button is disabled.
  final VoidCallback? onPressed;

  /// The text displayed inside the button.
  final String text;

  /// An optional icon displayed to the right of the text.
  final IconData? icon;

  /// Whether this is a primary (accent color) or secondary (surface color)
  /// button.
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primary : AppColors.cardGrey,
        foregroundColor: isPrimary ? AppColors.textBlack : AppColors.textWhite,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.s20),
        elevation: isPrimary ? 4 : 0,
        shadowColor:
            isPrimary ? AppColors.primary.withValues(alpha: 0.4) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.lg), // 24
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: AppSpacing.md,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Icon(
              icon,
              size: AppSpacing.s20,
              weight: 800,
            ),
          ],
        ],
      ),
    );
  }
}
