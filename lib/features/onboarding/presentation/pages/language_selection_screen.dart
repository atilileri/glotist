import 'dart:async';
import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/l10n/app_localizations.dart';

/// Screen for selecting native and target languages.
class LanguageSelectionScreen extends StatefulWidget {
  /// Creates a [LanguageSelectionScreen] instance.
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // Static mapping for native language names
  static const Map<String, String> _nativeLanguageNames = {
    // Display languages (native interface languages)
    'en': 'English (United States)',
    'es': 'Español',
    'fr': 'Français',
    'tr': 'Türkçe',
    'de': 'Deutsch',
    'nl': 'Nederlands',

    // Target languages (languages to learn)
    'jp': '日本語',
    'it': 'Italiano',
    'pt': 'Português',
    'kr': '한국어',
  };

  // Helper to get native language name
  static String _getLanguageNameLocale(String localeCode) {
    return _nativeLanguageNames[localeCode] ?? localeCode.toUpperCase();
  }

  // Helper to generate Display Languages data
  List<Map<String, String>> _getDisplayLanguages() {
    return [
      {'name': _getLanguageNameLocale('en'), 'isoCode': 'us', 'locale': 'en'},
      {'name': _getLanguageNameLocale('es'), 'isoCode': 'es', 'locale': 'es'},
      {'name': _getLanguageNameLocale('fr'), 'isoCode': 'fr', 'locale': 'fr'},
      {'name': _getLanguageNameLocale('tr'), 'isoCode': 'tr', 'locale': 'tr'},
      {'name': _getLanguageNameLocale('de'), 'isoCode': 'de', 'locale': 'de'},
      {'name': _getLanguageNameLocale('nl'), 'isoCode': 'nl', 'locale': 'nl'},
    ];
  }

  // Helper to generate Learnable Languages data
  List<Map<String, String>> _getTargetLanguages(AppLocalizations l10n) {
    return [
      {
        'name': l10n.langJapanese,
        'nativeName': _getLanguageNameLocale('jp'),
        'isoCode': 'jp',
      },
      {
        'name': l10n.langItalian,
        'nativeName': _getLanguageNameLocale('it'),
        'isoCode': 'it',
      },
      {
        'name': l10n.langPortuguese,
        'nativeName': _getLanguageNameLocale('pt'),
        'isoCode': 'pt',
      },
      {
        'name': l10n.langKorean,
        'nativeName': _getLanguageNameLocale('kr'),
        'isoCode': 'kr',
      },
      {
        'name': l10n.langTurkish,
        'nativeName': _getLanguageNameLocale('tr'),
        'isoCode': 'tr',
      },
      {
        'name': l10n.langDutch,
        'nativeName': _getLanguageNameLocale('nl'),
        'isoCode': 'nl',
      },
    ];
  }

  // State
  String _targetLanguage = 'jp'; // Store isoCode

  @override
  void initState() {
    super.initState();
  }

  void _onNativeLanguageChanged(String? newValue) {
    if (newValue == null) return;
    unawaited(
      context.read<LocalizationCubit>().changeLocale(newValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context).languageCode;

    final displayLanguages = _getDisplayLanguages();
    final learnableLanguages = _getTargetLanguages(l10n);

    // Define styles based on theme
    final surfaceColor =
        isDark ? AppColors.backgroundDark : theme.scaffoldBackgroundColor;
    final cardColor = isDark ? AppColors.cardGrey : Colors.white;
    final borderColor = isDark ? AppColors.borderGrey : Colors.grey.shade300;
    final textColor = isDark ? Colors.white : AppColors.textBlack;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Disabled Back Button
                          IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.arrow_back,
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                l10n.step1of3,
                                style: TextStyle(
                                  fontSize: constraints.maxWidth > 400
                                      ? 10
                                      : 8, // Responsive font
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.5,
                                  color: subTextColor,
                                ),
                              ),
                            ),
                          ),
                          // Theme Switch
                          IconButton(
                            onPressed: () {
                              unawaited(
                                context.read<ThemeCubit>().toggleTheme(),
                              );
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: cardColor,
                              padding: const EdgeInsets.all(8),
                            ),
                            icon: BlocBuilder<ThemeCubit, ThemeMode>(
                              builder: (context, themeMode) {
                                IconData icon;
                                switch (themeMode) {
                                  case ThemeMode.system:
                                    icon = Icons.brightness_auto;
                                  case ThemeMode.light:
                                    icon = Icons.light_mode;
                                  case ThemeMode.dark:
                                    icon = Icons.dark_mode;
                                }
                                return Icon(
                                  icon,
                                  color: AppColors.primary,
                                  size: constraints.maxWidth > 400
                                      ? 20
                                      : 16, // Responsive icon
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Progress Bar
                      Container(
                        width: double.infinity,
                        height: 6,
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.33,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Title & Subtitle
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.letsGetStarted,
                          style: TextStyle(
                            fontSize: constraints.maxWidth > 600
                                ? 28
                                : constraints.maxWidth > 400
                                    ? 24
                                    : 20, // Responsive title
                            fontWeight: FontWeight.w800,
                            color: textColor,
                            height: 1.1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.refineExperience,
                          style: TextStyle(
                            fontSize: constraints.maxWidth > 400
                                ? 14
                                : 12, // Responsive subtitle
                            color: subTextColor,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // --- Scrollable Content ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 120),
                children: [
                  // 1. Native Language Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(l10n.displayLanguage, subTextColor),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: cardColor,
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: currentLocale,
                              isExpanded: true,
                              dropdownColor: cardColor,
                              icon:
                                  Icon(Icons.expand_more, color: subTextColor),
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Plus Jakarta Sans',
                              ),
                              onChanged: _onNativeLanguageChanged,
                              items: displayLanguages.map((lang) {
                                return DropdownMenuItem(
                                  value: lang['locale'],
                                  child: Row(
                                    children: [
                                      // Using a generic globe icon
                                      Icon(
                                        Icons.language,
                                        color: subTextColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(lang['name']!),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: 14,
                                color: subTextColor,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  l10n.displayLanguageDisclaimer,
                                  style: TextStyle(
                                    fontSize: 11,
                                    height: 1.4,
                                    color: subTextColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2. LANGUAGE TO LEARN Section
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _sectionTitle(l10n.languageToLearn, subTextColor),
                  ),
                  const SizedBox(height: 16),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Calculate responsive crossAxisCount based on
                      // available width
                      final crossAxisCount = constraints.maxWidth > 600
                          ? 3
                          : constraints.maxWidth > 400
                              ? 2
                              : 1;
                      final itemWidth =
                          (constraints.maxWidth - (crossAxisCount - 1) * 16) /
                              crossAxisCount;

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: itemWidth /
                              (itemWidth * 1.2), // Responsive aspect ratio
                        ),
                        itemCount: learnableLanguages.length,
                        itemBuilder: (context, index) {
                          final lang = learnableLanguages[index];
                          final isSelected = _targetLanguage == lang['isoCode'];

                          return GestureDetector(
                            onTap: () => setState(
                              () => _targetLanguage = lang['isoCode']!,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.1)
                                    : cardColor,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.2),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: CircleFlag(
                                            lang['isoCode']!,
                                            size: constraints.maxWidth > 400
                                                ? 64
                                                : 48, // Responsive flag size
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          lang['name']!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: constraints.maxWidth > 400
                                                ? 16
                                                : 14, // Responsive font
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          lang['nativeName']!,
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth > 400
                                                ? 12
                                                : 10, // Responsive font
                                            fontWeight: FontWeight.w500,
                                            color: isSelected
                                                ? AppColors.primary
                                                : subTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    const Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: AppColors.primary,
                                        size: 24,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // See all button
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: borderColor),
                        backgroundColor: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.seeAllLanguages,
                            style: TextStyle(
                              color: subTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: subTextColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- Bottom Floating Button ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              surfaceColor,
              surfaceColor.withValues(alpha: 0.95),
              surfaceColor.withValues(alpha: 0),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              // Action to continue
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textBlack,
              padding: const EdgeInsets.symmetric(vertical: 20),
              elevation: 4,
              shadowColor: AppColors.primary.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.continueAction,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 20, weight: 800),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        color: color,
      ),
    );
  }
}
