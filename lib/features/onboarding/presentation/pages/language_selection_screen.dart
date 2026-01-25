import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// Screen for selecting native and target languages.
class LanguageSelectionScreen extends StatefulWidget {
  /// Creates a [LanguageSelectionScreen] instance.
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final String _nativeLanguage = 'English (United States)';
  final List<Map<String, String>> _otherLanguages = [
    {
      'name': 'French',
      'flag':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCRyuKgY5qKsT5AYIgDy9YDHPEAwES9ftff8Fz9o6HoDjaLw1Hp3muwnDzUWASOfzrRVSVhuPEm93y5YA7HHAZjJDqW8BSqsdqQpPtWHHSdX7logIehXkei6U2g3NQJfcXeLMdeQVSDDAw3oEvooFuf3zsq1Mo2FUR14ThG4kM7Q9oJCYHJWc31qtZ-Upjo5sR2xn7SKQs7S50ODXllrnVDEutorLR_cgmJWRx1OvtP46qKJbVZZWro44LOsNv5cL02eum89qfupf8N',
    },
    {
      'name': 'German',
      'flag':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBRJj4TyXXwphJZkSK8jGJVdaufh5BEK35lvktnvObBa8bK5iH3YpOQ7mepeDmC_GbdTyNRBPv10Mx-m-2ROtNFVpmE6K7jTUNd0wKUSi--8A_uiauc4j98rEHOaDV4a07m2FQhb9SlAzLScF_ufG7OCVF5GW_Y2wRVk-NwF-BYhbyreV8Oh9ImliDB7_q0faJWP9W2pKX0HFzqh5mhanhJvHupWBKaV1qirBTqSMlzBCR2FL0OeV9h6_hQGmprwFdnyQms4B7Kwi3_',
    },
  ];

  String _targetLanguage = 'Japanese';

  final List<Map<String, String>> _learnableLanguages = [
    {
      'name': 'Japanese',
      'localName': '日本語',
      'flag':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDwfKbzHPVNF7gxz6FZHxI76qtEkQOlEtf1IKvAeQq4pS5oDWXfzf8GNIqKd0HvzVxX1QvQiSp4q-vZZBoSq422an7uEEFsie4NiTHI5NWBC94rjAIgUxStnXop-F0hsnPYeY9EO-64hZPknBcJqnY5hrMgWuPEC-faecMp_YslFngvWXSBfFeoR9lxXB63KknqcMCVirzWeEUG3xQ9OtLl_tHCp8RhYuCL5xBvnO4qIoUt9iI817gxkNsaooikcbGVBVCoKHfoQab2',
    },
    {
      'name': 'Italian',
      'localName': 'Italiano',
      'flag':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBlcckj2Kmha2BIesVlMmnOdtQe4wQmDcDAiSjS3VX1zckS072VEb5s3kozjy_ETYYywt7NFCBG4zXIvw_M5yN-Jep0ep2hQ_R8BLI2l-MxOEAOSypidDCspASO2KDPXrxqrQpBqVadpFP3xSb6Pv3zYipQjtstwHvrZX_bsjphWCxqAQzBKGi0Fwi0h_Q9O0AYwn8lmgUWPGBxwegDyLDcmqxl4r4jt_IXQilhSLo7Pjh8hFNu1wqWjWsIr8KHtRn9nh-O-XDQ13ce',
    },
    {
      'name': 'Portuguese',
      'localName': 'Português',
      'flag':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDpSuW_Pk8qf0w0LlOPK6_QDJK6YCXHkRHSorAPACTCXyFJs1wcpRH7rgDtZRmh4i1NUBAkZirJZvkoHMSCEFPuw07Sqm4tme47egjM4NQORJ8aYJBAuUWBO6TntdK_TzCmq54RZzPRl8pFCnJllxpkBLYZkuFYTTon1BGQNyh6-9R0Yd5g0SR0E9NYTZRxBYcoy1iawn3iP9SBHiDxQAv6G29dMFZWVXBLh_G6cIY0TO4d2PytIvltIIUKTTP_tUWuImVB8hEr-Idi',
    },
    {
      'name': 'Korean',
      'localName': '한국어',
      'flag':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBbVeJUzk6ELjLVhnmnpBp4kRBWamASS1M3WnRbpAIJU6EQh1W1zAoTL2wudgeRCqr8UHAK-lW4zTXtUCBj0aLKlD-mGyJLVyRM4L7tsHWX9Pms84kAQg1oTU12xQX0C1k6aD6vJ2OdVQbDL-kDoaCGXgLmBS_voR2NymeHqqsETWgkTTH90S3H5tM_iWE5XYMo01W4Db4bvcPClUUTQ01Vtmu1sP33r7cJR1YnwOJRyZJ-r50benAMtSrXs8sJxqvVS52a1c0lrO9Y',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      Text(
                        'STEP 1 OF 3',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                      ),
                      const SizedBox(
                        width: 48,
                      ), // Spacer to balance back button
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.33,
                      minHeight: 6,
                      backgroundColor: isDark ? Colors.white10 : Colors.black12,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(colorScheme.primary),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Pick your languages',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Help us customize your experience to your level.',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Native Language Section
                  _buildSectionHeader('NATIVE LANGUAGE', isDark),
                  const SizedBox(height: 12),
                  _buildDropdownSelector(
                    icon: Icons.language,
                    value: _nativeLanguage,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 32),

                  // Other Languages Section
                  _buildSectionHeader('OTHER LANGUAGES', isDark),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _otherLanguages.map((lang) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _buildLanguageChip(
                            lang['name']!,
                            lang['flag']!,
                            isDark,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Target Language Section
                  _buildSectionHeader('I WANT TO LEARN', isDark),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _learnableLanguages.length,
                    itemBuilder: (context, index) {
                      final lang = _learnableLanguages[index];
                      final isSelected = _targetLanguage == lang['name'];
                      return _buildTargetCard(
                        lang,
                        isSelected,
                        isDark,
                        colorScheme,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // See all button
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.expand_more, size: 18),
                      label: const Text('See all 40+ languages'),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            isDark ? Colors.white54 : Colors.black54,
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.05),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ), // Bottom padding for sticky button
                ],
              ),
            ),
            // Sticky Continue Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      (isDark ? const Color(0xFF0F172A) : Colors.white)
                          .withValues(alpha: 0),
                      (isDark ? const Color(0xFF0F172A) : Colors.white)
                          .withValues(alpha: 0.95),
                      if (isDark) const Color(0xFF0F172A) else Colors.white,
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/choice');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: const Color(0xFF0F172A),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10,
                    shadowColor: colorScheme.primary.withValues(alpha: 0.4),
                  ).copyWith(
                    elevation: WidgetStateProperty.all(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, weight: 900),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a section header with the given [title].
  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 2,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
    );
  }

  /// Builds a dropdown-style selector for language.
  Widget _buildDropdownSelector({
    required IconData icon,
    required String value,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDark ? Colors.white38 : Colors.black38, size: 20),
          const SizedBox(width: 12),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.expand_more,
            color: isDark ? Colors.white38 : Colors.black38,
          ),
        ],
      ),
    );
  }

  /// Builds a chip widget for "Other Languages" list.
  Widget _buildLanguageChip(String name, String flagUrl, bool isDark) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.02),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              flagUrl,
              width: 28,
              height: 28,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.close,
            size: 16,
            color: isDark ? Colors.white38 : Colors.black38,
          ),
        ],
      ),
    );
  }

  /// Builds a selectable card for a target language.
  Widget _buildTargetCard(
    Map<String, String> lang,
    bool isSelected,
    bool isDark,
    ColorScheme colorScheme,
  ) {
    return GestureDetector(
      key: ValueKey('lang_${lang['name']}'),
      onTap: () => setState(() => _targetLanguage = lang['name']!),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.05)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.black.withValues(alpha: 0.02)),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                top: 12,
                right: 12,
                child: Icon(Icons.check_circle, color: colorScheme.primary),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(lang['flag']!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    lang['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    lang['localName']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? colorScheme.primary
                          : (isDark ? Colors.white38 : Colors.black38),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
