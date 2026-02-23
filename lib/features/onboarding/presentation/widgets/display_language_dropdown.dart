import 'dart:async';

import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/models/language_model.dart';
import 'package:glotist_app/core/theme/app_colors.dart';

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
    final isDark = theme.brightness == Brightness.dark;
    final currentLocale = Localizations.localeOf(context).languageCode;

    final cardColor = isDark ? AppColors.cardGrey : Colors.grey.shade50;
    final borderColor = isDark ? AppColors.borderGrey : Colors.grey.shade100;
    final textColor = isDark ? Colors.white : AppColors.textBlack;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Semantics(
      label: 'Display language selection',
      container: true,
      child: Container(
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
            key: const Key('display_language_dropdown'),
            value: currentLocale,
            isExpanded: true,
            dropdownColor: cardColor,
            icon: Icon(
              Icons.expand_more,
              color: subTextColor,
            ),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
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
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        lang.nativeName,
                        overflow: TextOverflow.ellipsis,
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
