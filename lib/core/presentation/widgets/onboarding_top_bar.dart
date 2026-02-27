import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';
import 'package:glotist_app/features/onboarding/presentation/pages/language_selection_screen.dart'
    show LanguageSelectionScreen;
import 'package:glotist_app/features/onboarding/presentation/pages/onboarding_conversation_screen.dart'
    show OnboardingConversationScreen;

/// A shared top bar for onboarding screens.
///
/// Displays a back button, centered title, optional trailing widget, and a
/// progress bar. Used by both [LanguageSelectionScreen] and
/// [OnboardingConversationScreen] with different trailing widgets.
class OnboardingTopBar extends StatelessWidget {
  /// Creates an [OnboardingTopBar] instance.
  const OnboardingTopBar({
    required this.title,
    required this.progress,
    super.key,
    this.onBack,
    this.trailing,
  });

  /// The centered title text.
  final String title;

  /// Progress fraction from 0.0 to 1.0 for the progress bar.
  final double progress;

  /// Callback when the back button is tapped. If null, the button is
  /// visually disabled.
  final VoidCallback? onBack;

  /// Optional trailing widget (e.g. theme toggle or "Skip" pill button).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.xs,
            top: AppSpacing.xs,
            right: AppSpacing.md,
            bottom: AppSpacing.sm,
          ),
          child: Row(
            children: [
              // Back button
              IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.arrow_back,
                  color: onBack != null
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),

              // Centered title
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: AppSpacing.md,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              // Trailing widget or spacer for symmetry
              if (trailing != null)
                trailing!
              else
                const SizedBox(width: AppSpacing.xxl),
            ],
          ),
        ),

        // Progress bar
        Container(
          width: double.infinity,
          height: AppSpacing.xs,
          color: colorScheme.outline,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppSpacing.pill),
                  bottomRight: Radius.circular(AppSpacing.pill),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                    blurRadius: AppSpacing.s10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
