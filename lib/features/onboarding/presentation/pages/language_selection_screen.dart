import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';
import 'package:glotist_app/core/utils/preview_helper.dart';
import 'package:glotist_app/features/onboarding/presentation/widgets/display_language_dropdown.dart';
import 'package:glotist_app/features/onboarding/presentation/widgets/language_grid.dart';
import 'package:glotist_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// Screen for selecting display and target languages.
class LanguageSelectionScreen extends StatefulWidget {
  /// Creates a [LanguageSelectionScreen] instance.
  @AppPreview(name: 'Language Selection')
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // Local ephemeral state for selected target language
  // TODO(agent): do not start with a selected language.
  // Let the user select one.
  String _targetLanguageCode = 'jp';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    final localizationCubit = context.watch<LocalizationCubit>();
    final displayLanguages = localizationCubit.displayLanguages;
    final targetLanguages = localizationCubit.targetLanguages;

    final surfaceColor =
        isDark ? AppColors.backgroundDark : theme.scaffoldBackgroundColor;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: surfaceColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            _buildHeader(context, isDark, subTextColor, l10n),

            // --- Scrollable Content ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 120),
                children: [
                  // 1. Display Language Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(l10n.displayLanguage, subTextColor),
                        const SizedBox(height: 12),
                        DisplayLanguageDropdown(
                          displayLanguages: displayLanguages,
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
                  LanguageGrid(
                    languages: targetLanguages,
                    selectedLanguageCode: _targetLanguageCode,
                    onLanguageSelected: (code) {
                      setState(() {
                        _targetLanguageCode = code;
                      });
                    },
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
          child: Semantics(
            label: 'Continue to next step',
            button: true,
            child: ElevatedButton(
              onPressed: () {
                context.go('/choice');
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
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    weight: 800,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isDark,
    Color subTextColor,
    AppLocalizations l10n,
  ) {
    final cardColor = isDark ? AppColors.cardGrey : Colors.grey.shade50;
    final borderColor = isDark ? AppColors.borderGrey : Colors.grey.shade100;
    final textColor = isDark ? Colors.white : AppColors.textBlack;

    return Padding(
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
                      color:
                          isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        l10n.step1of3,
                        style: TextStyle(
                          fontSize: constraints.maxWidth > 400 ? 10 : 8,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: subTextColor,
                        ),
                      ),
                    ),
                  ),
                  // Theme Switch
                  Semantics(
                    label: 'Theme toggle',
                    button: true,
                    child: IconButton(
                      onPressed: () {
                        unawaited(context.read<ThemeCubit>().toggleTheme());
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
                            size: constraints.maxWidth > 400 ? 20 : 16,
                          );
                        },
                      ),
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
                            : 20,
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
                    fontSize: constraints.maxWidth > 400 ? 14 : 12,
                    color: subTextColor,
                  ),
                ),
              ),
            ],
          );
        },
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
