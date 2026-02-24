import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';

/// A card displaying a language option with its flag and name.
class LanguageOptionCard extends StatelessWidget {
  /// Creates a [LanguageOptionCard].
  const LanguageOptionCard({
    required this.language,
    required this.localizedName,
    required this.isSelected,
    required this.onTap,
    required this.maxWidth,
    super.key,
  });

  /// The language model data.
  final LanguageModel language;

  /// The localized name to display.
  final String localizedName;

  /// Whether the card is currently selected.
  final bool isSelected;

  /// Callback when the card is tapped.
  final VoidCallback onTap;

  /// The maximum width available, used for responsive adjustments.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      label: '$localizedName language option${isSelected ? ', selected' : ''}',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.1)
                : colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: isSelected ? colorScheme.primary : colorScheme.outline,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(AppSpacing.lg),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleFlag(
                        language.isoCode,
                        size: maxWidth > 400
                            ? AppSpacing.section
                            : AppSpacing.xxl,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      localizedName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            maxWidth > 400 ? AppSpacing.md : AppSpacing.s14,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      language.nativeName,
                      style: TextStyle(
                        fontSize:
                            maxWidth > 400 ? AppSpacing.s14 : AppSpacing.s12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: AppSpacing.s12,
                  right: AppSpacing.s12,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: AppSpacing.md,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
