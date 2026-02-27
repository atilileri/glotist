import 'package:flutter/material.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';

/// A styled chat message bubble used in the onboarding conversation.
///
/// Renders differently for AI messages (left-aligned with avatar) and
/// user messages (right-aligned with primary background).
class ChatMessageBubble extends StatelessWidget {
  /// Creates a [ChatMessageBubble] instance.
  const ChatMessageBubble({
    required this.message,
    super.key,
    this.statusText,
    this.avatarAsset,
  });

  /// The message to display.
  final Message message;

  /// Optional status text shown below user messages (e.g. "INTERESTS NOTED").
  final String? statusText;

  /// Asset path for the AI avatar image. Ignored for user messages.
  final String? avatarAsset;

  @override
  Widget build(BuildContext context) {
    return message.isUser ? _buildUserBubble(context) : _buildAiBubble(context);
  }

  Widget _buildAiBubble(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: AppSpacing.xl,
            height: AppSpacing.xl,
            margin: const EdgeInsets.only(top: AppSpacing.xs),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.outline),
              image: avatarAsset != null
                  ? DecorationImage(
                      image: AssetImage(avatarAsset!),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    )
                  : null,
              color: colorScheme.surfaceContainerHighest,
            ),
            child: avatarAsset == null
                ? Icon(
                    Icons.smart_toy_outlined,
                    size: AppSpacing.md,
                    color: colorScheme.onSurfaceVariant,
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.s12),

          // Bubble
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.s12,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border.all(color: colorScheme.outline),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.xs),
                  topRight: Radius.circular(AppSpacing.s20),
                  bottomLeft: Radius.circular(AppSpacing.s20),
                  bottomRight: Radius.circular(AppSpacing.s20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.onSurface.withValues(alpha: 0.04),
                    blurRadius: AppSpacing.xs,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  fontSize: AppSpacing.s14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // TODO(atilileri): AI and user bubble design should similar,
  // only difference is alignment and color.
  Widget _buildUserBubble(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Bubble
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.s12,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.s20),
                  topRight: Radius.circular(AppSpacing.xs),
                  bottomLeft: Radius.circular(AppSpacing.s20),
                  bottomRight: Radius.circular(AppSpacing.s20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: AppSpacing.xs,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  fontSize: AppSpacing.s14,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),

          // Status chip
          if (statusText != null)
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.xs,
                right: AppSpacing.xs,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: AppSpacing.s12,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    statusText!,
                    style: TextStyle(
                      fontSize: AppSpacing.s10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
