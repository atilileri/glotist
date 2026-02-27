import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';

/// A styled secondary button for the Glotist application, typically used
/// for less prominent actions like "See all."
class GlotistSecondaryButton extends StatelessWidget {
  /// Creates a [GlotistSecondaryButton] instance.
  const GlotistSecondaryButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.icon,
  });

  /// Callback when the button is tapped.
  final VoidCallback? onPressed;

  /// The text displayed inside the button.
  final String text;

  /// An optional icon displayed to the right of the text.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Semantics(
      button: true,
      enabled: onPressed != null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          side: BorderSide(color: colorScheme.outline),
          backgroundColor: colorScheme.surfaceContainerHighest,
          foregroundColor: colorScheme.onSurfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.lg),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Icon(
                icon,
                size: AppSpacing.s20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
