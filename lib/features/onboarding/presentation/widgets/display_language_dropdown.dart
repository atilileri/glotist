import 'dart:async';

import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';

/// A dropdown selector for the display language.
class DisplayLanguageDropdown extends StatelessWidget {
  /// Creates a [DisplayLanguageDropdown].
  const DisplayLanguageDropdown({
    required this.displayLanguages,
    super.key,
  });

  /// The list of available display languages.
  final List<LanguageModel> displayLanguages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Semantics(
      label: 'Display language selection',
      container: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(AppSpacing.md),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            key: const Key('display_language_dropdown'),
            value: currentLocale,
            isExpanded: true,
            dropdownColor: colorScheme.surfaceContainerHighest,
            icon: Icon(
              Icons.expand_more,
              color: colorScheme.onSurfaceVariant,
            ),
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: AppSpacing.md,
              fontFamily: 'Plus Jakarta Sans',
            ),
            onChanged: (newValue) {
              if (newValue != null) {
                unawaited(
                  context.read<LocalizationCubit>().changeLocale(newValue),
                );
              }
            },
            items: displayLanguages.map((lang) {
              return DropdownMenuItem(
                value: lang.code,
                child: Row(
                  children: [
                    CircleFlag(
                      lang.isoCode,
                      size: AppSpacing.s20,
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    Expanded(
                      child: Text(
                        lang.nativeName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
