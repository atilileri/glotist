import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glotist_app/core/di/injection_container.dart';
import 'package:glotist_app/core/presentation/widgets/chat_input_bar.dart';
import 'package:glotist_app/core/presentation/widgets/chat_message_bubble.dart';
import 'package:glotist_app/core/presentation/widgets/onboarding_substep_indicator.dart';
import 'package:glotist_app/core/presentation/widgets/onboarding_top_bar.dart';
import 'package:glotist_app/core/theme/app_spacing.dart';
import 'package:glotist_app/core/theme/theme_extensions.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';
import 'package:glotist_app/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// Path to the AI avatar asset used in chat bubbles.
const _aiAvatarAsset = 'assets/images/ai_avatar.png';

/// Temporary delay in seconds to visualize the typing animation.
const _typingDelaySeconds = 5;

/// Screen for the onboarding conversation with the AI agent.
///
/// This is the second screen in the onboarding flow, following the
/// language selection screen. It uses a chat-based interface to collect
/// user interests, proficiency level, and learning purpose.
class OnboardingConversationScreen extends StatefulWidget {
  /// Creates an [OnboardingConversationScreen] instance.
  const OnboardingConversationScreen({super.key});

  @override
  State<OnboardingConversationScreen> createState() =>
      _OnboardingConversationScreenState();
}

class _OnboardingConversationScreenState
    extends State<OnboardingConversationScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  bool _isLoading = false;

  // TODO(atilileri): just for demo purposes. will be removed later.
  Timer? _welcomeTimer;
  late final ChatRemoteDataSource _chatSource;

  @override
  void initState() {
    super.initState();
    _chatSource = sl<ChatRemoteDataSource>();
    _addAiMessage(
      "Let's make sure I teach you what you care about.",
    );
    // Simulate a follow-up question after a brief delay.
    _welcomeTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        _addAiMessage(
          'What are your favorite hobbies? I can use them to personalize '
          'your lessons!',
        );
      }
    });
  }

  @override
  void dispose() {
    _welcomeTimer?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Adds an AI message to the chat list.
  void _addAiMessage(String content) {
    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          content: content,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
    _scrollToBottom();
  }

  /// Sends the user's message and fetches an AI response.
  Future<void> _sendMessage(String text) async {
    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          content: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isLoading = true;
      _controller.clear();
    });
    _scrollToBottom();

    try {
      // Temporary artificial delay to visualize typing animation.
      await Future<void>.delayed(
        const Duration(seconds: _typingDelaySeconds),
      );

      final response = await _chatSource.sendMessage(text);
      if (mounted) {
        setState(() {
          _messages.add(response);
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        unawaited(
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = context.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top bar
            OnboardingTopBar(
              title: l10n.profileSetup,
              progress: 0.66,
              onBack: () => context.pop(),
              trailing: _SkipPillButton(
                label: l10n.skip,
                onPressed: () {
                  // TODO(atilileri): Implement skip action
                },
              ),
            ),

            // Substep indicator
            OnboardingSubstepIndicator(
              currentSubstep: 1,
              labels: [
                l10n.substepInterests,
                l10n.substepLevel,
                l10n.substepPurpose,
              ],
            ),

            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                itemCount: _messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  // Typing indicator as last item when loading
                  if (index == _messages.length) {
                    return const _TypingIndicator();
                  }

                  final message = _messages[index];
                  return ChatMessageBubble(
                    message: message,
                    avatarAsset: message.isUser ? null : _aiAvatarAsset,
                    statusText: _statusForMessage(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Input bar
      bottomNavigationBar: ChatInputBar(
        controller: _controller,
        hintText: l10n.typeAMessage,
        enabled: !_isLoading,
        onSubmitted: _sendMessage,
      ),
    );
  }

  /// Returns status text for user messages, or null.
  String? _statusForMessage(int index) {
    if (!_messages[index].isUser) return null;

    // Simple heuristic: first user message gets "INTERESTS NOTED",
    // subsequent ones get "ADDED".
    final userMessageIndex =
        _messages.sublist(0, index + 1).where((m) => m.isUser).length;
    if (userMessageIndex == 1) return 'INTERESTS NOTED';
    return 'ADDED';
  }
}

/// Small pill-shaped "Skip" button for the top bar trailing slot.
class _SkipPillButton extends StatelessWidget {
  const _SkipPillButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: colorScheme.primary,
      borderRadius: BorderRadius.circular(AppSpacing.pill),
      elevation: 2,
      shadowColor: colorScheme.primary.withValues(alpha: 0.2),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSpacing.pill),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppSpacing.s12,
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated typing indicator shown when the AI is composing a response.
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: _PulsingText(
          text: 'TYPING...',
          style: TextStyle(
            fontSize: AppSpacing.s10,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}

/// Text widget with a subtle pulsing opacity animation.
class _PulsingText extends StatefulWidget {
  const _PulsingText({
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  State<_PulsingText> createState() => _PulsingTextState();
}

class _PulsingTextState extends State<_PulsingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      // Duration of one pulse cycle (fade in/out).
      duration: const Duration(milliseconds: 1200),
    );
    unawaited(_animationController.repeat(reverse: true));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Text(widget.text, style: widget.style),
    );
  }
}
