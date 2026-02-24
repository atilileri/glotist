import 'package:flutter/material.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/features/onboarding/presentation/widgets/language_option_card.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

/// A responsive grid displaying available target languages to learn.
class LanguageGrid extends StatelessWidget {
  /// Creates a [LanguageGrid].
  const LanguageGrid({
    required this.languages,
    required this.selectedLanguageCode,
    required this.onLanguageSelected,
    super.key,
  });

  /// The list of target languages.
  final List<LanguageModel> languages;

  /// The currently selected language code.
  final String selectedLanguageCode;

  /// Callback when a language is selected.
  final ValueChanged<String> onLanguageSelected;

  String _getLocalizedName(String code, AppLocalizations l10n) {
    switch (code) {
      // TODO(agent): can't we read the cases from the language_repository?
      case 'jp':
        return l10n.langJapanese;
      case 'it':
        return l10n.langItalian;
      case 'pt':
        return l10n.langPortuguese;
      case 'kr':
        return l10n.langKorean;
      case 'tr':
        return l10n.langTurkish;
      case 'nl':
        return l10n.langDutch;
      default:
        return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive crossAxisCount based on available width
        final crossAxisCount = constraints.maxWidth > 600
            ? 3
            : constraints.maxWidth > 400
                ? 2
                : 1;
        final itemWidth =
            (constraints.maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio:
                itemWidth / (itemWidth * 1.2), // Responsive aspect ratio
          ),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final lang = languages[index];
            final isSelected = selectedLanguageCode == lang.code;
            final localizedName = _getLocalizedName(lang.code, l10n);

            return LanguageOptionCard(
              language: lang,
              localizedName: localizedName,
              isSelected: isSelected,
              maxWidth: constraints.maxWidth,
              onTap: () => onLanguageSelected(lang.code),
            );
          },
        );
      },
    );
  }
}
