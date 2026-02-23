import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_colors.dart';

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
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark ? AppColors.cardGrey : Colors.grey.shade50;
    final borderColor = isDark ? AppColors.borderGrey : Colors.grey.shade100;
    final textColor = isDark ? Colors.white : AppColors.textBlack;

    return Semantics(
      label: '$localizedName language option${isSelected ? ', selected' : ''}',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.1)
                : cardColor,
            border: Border.all(
              color: isSelected ? AppColors.primary : borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(24),
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
                        size: maxWidth > 400 ? 64 : 48,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      localizedName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: maxWidth > 400 ? 16 : 14,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      language.nativeName,
                      style: TextStyle(
                        fontSize: maxWidth > 400 ? 14 : 12,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
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
