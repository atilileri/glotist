import 'dart:async';
import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glotist_app/core/localization/cubit/localization_cubit.dart';
import 'package:glotist_app/core/theme/app_colors.dart';
import 'package:glotist_app/core/theme/cubit/theme_cubit.dart';

/// Screen for selecting native and target languages.
class LanguageSelectionScreen extends StatefulWidget {
  /// Creates a [LanguageSelectionScreen] instance.
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  // Languages data
  final List<Map<String, String>> _nativeLanguages = [
    {'name': 'English (United States)', 'isoCode': 'us', 'locale': 'en'},
    {'name': 'Spanish', 'isoCode': 'es', 'locale': 'es'},
    {'name': 'French', 'isoCode': 'fr', 'locale': 'fr'},
    {'name': 'Turkish', 'isoCode': 'tr', 'locale': 'tr'},
    {'name': 'German', 'isoCode': 'de', 'locale': 'de'},
    {'name': 'Dutch', 'isoCode': 'nl', 'locale': 'nl'},
  ];

  final List<Map<String, String>> _otherLanguagesData = [
    {'name': 'French', 'isoCode': 'fr'},
    {'name': 'German', 'isoCode': 'de'},
    {'name': 'Turkish', 'isoCode': 'tr'},
    {'name': 'Dutch', 'isoCode': 'nl'},
    {'name': 'Spanish', 'isoCode': 'es'},
  ];

  final List<Map<String, String>> _learnableLanguagesData = [
    {'name': 'Japanese', 'localName': '日本語', 'isoCode': 'jp'},
    {'name': 'Italian', 'localName': 'Italiano', 'isoCode': 'it'},
    {'name': 'Portuguese', 'localName': 'Português', 'isoCode': 'pt'},
    {'name': 'Korean', 'localName': '한국어', 'isoCode': 'kr'},
    {'name': 'Turkish', 'localName': 'Türkçe', 'isoCode': 'tr'},
    {'name': 'Dutch', 'localName': 'Nederlands', 'isoCode': 'nl'},
  ];

  // State
  late String _selectedNativeLanguage;
  final Set<String> _selectedOtherLanguages = {};
  String _targetLanguage = 'Japanese';

  @override
  void initState() {
    super.initState();
    _selectedNativeLanguage = _nativeLanguages.first['name']!;
  }

  void _onNativeLanguageChanged(String? newValue) {
    if (newValue == null) return;
    setState(() {
      _selectedNativeLanguage = newValue;
    });

    final lang = _nativeLanguages.firstWhere((l) => l['name'] == newValue);
    if (lang.containsKey('locale')) {
      unawaited(
        context.read<LocalizationCubit>().changeLocale(lang['locale']!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              child: Column(
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
                      Text(
                        'STEP 1 OF 3',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: subTextColor,
                        ),
                      ),
                      // Theme Switch
                      IconButton(
                        onPressed: () {
                          unawaited(context.read<ThemeCubit>().toggleTheme());
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: cardColor,
                          padding: const EdgeInsets.all(8),
                        ),
                        icon: Icon(
                          isDark ? Icons.light_mode : Icons.dark_mode,
                          color: AppColors.primary,
                          size: 20,
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
                      'Pick your languages',
                      style: TextStyle(
                        fontSize: 28,
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
                      'Help us customize your experience to your level.',
                      style: TextStyle(
                        fontSize: 14,
                        color: subTextColor,
                      ),
                    ),
                  ),
                ],
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
                        _sectionTitle('NATIVE LANGUAGE', subTextColor),
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
                              value: _selectedNativeLanguage,
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
                              items: _nativeLanguages.map((lang) {
                                return DropdownMenuItem(
                                  value: lang['name'],
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
                      ],
                    ),
                  ),

                  // 2. Other Languages Section (Multi-select)
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _sectionTitle('OTHER LANGUAGES', subTextColor),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: _otherLanguagesData.map((lang) {
                        final isSelected =
                            _selectedOtherLanguages.contains(lang['name']);
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedOtherLanguages.remove(lang['name']);
                                } else {
                                  _selectedOtherLanguages.add(lang['name']!);
                                }
                              });
                            },
                            child: Container(
                              width: 145,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: cardColor,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : borderColor,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  CircleFlag(lang['isoCode']!, size: 28),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      lang['name']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.close,
                                      size: 18,
                                      color: subTextColor,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // 3. I want to learn Section
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _sectionTitle('I WANT TO LEARN', subTextColor),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _learnableLanguagesData.length,
                    itemBuilder: (context, index) {
                      final lang = _learnableLanguagesData[index];
                      final isSelected = _targetLanguage == lang['name'];

                      return GestureDetector(
                        onTap: () =>
                            setState(() => _targetLanguage = lang['name']!),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        size: 64,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      lang['name']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      lang['localName']!,
                                      style: TextStyle(
                                        fontSize: 12,
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
                            'See all 40+ languages',
                            style: TextStyle(
                              color: subTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.expand_more,
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 20, weight: 800),
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
