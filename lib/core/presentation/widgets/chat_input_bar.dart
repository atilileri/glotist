import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';

/// Bottom input bar for the onboarding conversation chat.
///
/// Contains a rounded text field with a decorative emoji button and a
/// circular FAB that toggles between mic and send icons based on whether
/// the text field has content.
class ChatInputBar extends StatelessWidget {
  /// Creates a [ChatInputBar] instance.
  const ChatInputBar({
    required this.controller,
    required this.onSubmitted,
    super.key,
    this.hintText,
    this.onMicPressed,
    this.enabled = true,
  });

  /// The text editing controller for the input field.
  final TextEditingController controller;

  /// Callback when the user submits a message (tap send or press Enter).
  final ValueChanged<String> onSubmitted;

  /// Placeholder text for the input field.
  final String? hintText;

  /// Callback when the mic button is tapped (when input is empty).
  final VoidCallback? onMicPressed;

  /// Whether the input bar is enabled for interaction.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.s12,
        bottom: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: AppSpacing.s6,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Input field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      border: Border.all(color: colorScheme.outline),
                      borderRadius: BorderRadius.circular(AppSpacing.lg),
                    ),
                    child: Row(
                      children: [
                        // Decorative emoji button
                        Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.sm),
                          child: Icon(
                            Icons.sentiment_satisfied_alt_outlined,
                            size: AppSpacing.s20 + 2,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),

                        // Text field
                        Expanded(
                          child: TextField(
                            controller: controller,
                            enabled: enabled,
                            style: TextStyle(
                              fontSize: AppSpacing.s14,
                              color: colorScheme.onSurface,
                            ),
                            decoration: InputDecoration(
                              hintText: hintText,
                              hintStyle: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.s10,
                              ),
                            ),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _handleSubmit(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Mic / Send FAB
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (context, value, _) {
                    final hasText = value.text.trim().isNotEmpty;
                    return SizedBox(
                      width: AppSpacing.s40,
                      height: AppSpacing.s40,
                      child: Material(
                        color: colorScheme.primary,
                        shape: const CircleBorder(),
                        elevation: 4,
                        shadowColor: colorScheme.primary.withValues(alpha: 0.3),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: enabled
                              ? (hasText ? _handleSubmit : onMicPressed)
                              : null,
                          child: Icon(
                            hasText ? Icons.send : Icons.mic,
                            color: colorScheme.onPrimary,
                            size: AppSpacing.s20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Bottom handle indicator
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Container(
                width: AppSpacing.huge,
                height: AppSpacing.xs,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(AppSpacing.pill),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmit() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      onSubmitted(text);
    }
  }
}
