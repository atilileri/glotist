import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/presentation/widgets/glotist_button.dart';
import 'package:glotist_app/core/presentation/widgets/glotist_secondary_button.dart';
import 'package:glotist_app/core/theme/app_breakpoints.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
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
  String _targetLanguageCode = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final localizationCubit = context.watch<LocalizationCubit>();
    final displayLanguages = localizationCubit.displayLanguages;
    final targetLanguages = localizationCubit.targetLanguages;

    if (targetLanguages.isEmpty) {
      throw StateError('No target languages available');
    }

    final effectiveTargetLanguageCode = _targetLanguageCode.isNotEmpty
        ? _targetLanguageCode
        : targetLanguages.first.code;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            _buildHeader(context, colorScheme, l10n),

            // --- Scrollable Content ---
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: AppSpacing.huge),
                children: [
                  // 1. Display Language Section
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(
                          l10n.displayLanguage,
                          colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        DisplayLanguageDropdown(
                          displayLanguages: displayLanguages,
                        ),
                        const SizedBox(height: AppSpacing.s10),
                        Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.xs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline,
                                size: AppSpacing.s14,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: AppSpacing.s6),
                              Expanded(
                                child: Text(
                                  l10n.displayLanguageDisclaimer,
                                  style: TextStyle(
                                    fontSize: AppSpacing.s11,
                                    height: 1.4,
                                    color: colorScheme.onSurfaceVariant,
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
                  const SizedBox(height: AppSpacing.s40),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: _sectionTitle(
                      l10n.languageToLearn,
                      colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LanguageGrid(
                    languages: targetLanguages,
                    selectedLanguageCode: effectiveTargetLanguageCode,
                    onLanguageSelected: (code) {
                      setState(() {
                        _targetLanguageCode = code;
                      });
                    },
                  ),

                  // 3. See All Button
                  const SizedBox(height: AppSpacing.md),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: GlotistSecondaryButton(
                      onPressed: () {
                        // TODO(atilileri): Implement see all languages
                      },
                      text: l10n.seeAllLanguages,
                      icon: Icons.arrow_forward_rounded,
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
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              colorScheme.surface,
              colorScheme.surface.withValues(alpha: 0.95),
              colorScheme.surface.withValues(alpha: 0),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Semantics(
            label: 'Continue to next step',
            button: true,
            child: GlotistButton(
              onPressed: () {
                context.go('/choice');
              },
              text: l10n.continueAction,
              icon: Icons.arrow_forward_rounded,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.lg,
        top: AppSpacing.lg,
        right: AppSpacing.lg,
        bottom: AppSpacing.md,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.isCompact;

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
                      color: colorScheme.onSurface.withValues(alpha: 0.1),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        l10n.step1of3,
                        style: TextStyle(
                          fontSize: isCompact ? AppSpacing.sm : AppSpacing.s10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: colorScheme.onSurfaceVariant,
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
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        padding: const EdgeInsets.all(AppSpacing.sm),
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
                            color: colorScheme.primary,
                            size: isCompact ? AppSpacing.md : AppSpacing.s20,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              // Progress Bar
              Container(
                width: double.infinity,
                height: AppSpacing.s6,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(AppSpacing.pill),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.33,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(AppSpacing.pill),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              // Title & Subtitle
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.letsGetStarted,
                  style: TextStyle(
                    fontSize: constraints.isExpanded
                        ? AppSpacing.s28
                        : isCompact
                            ? AppSpacing.s20
                            : AppSpacing.lg,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.refineExperience,
                  style: TextStyle(
                    fontSize: isCompact ? AppSpacing.s12 : AppSpacing.s14,
                    color: colorScheme.onSurfaceVariant,
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
        fontSize: AppSpacing.s11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        color: color,
      ),
    );
  }
}
