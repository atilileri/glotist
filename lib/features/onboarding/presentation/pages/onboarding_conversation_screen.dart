import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glotist_app/core/di/injection_container.dart';
import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';

/// Screen for the onboarding conversation with the AI agent.
///
// TODO(atilileri): Implement gathering additional language information and
// proficiency levels through conversation that were previously collected in
// the "Other Languages" section. This should ask users about:
// - Additional languages they know
// - Their proficiency level in each language
// - Their learning goals for each language
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

  /// Chat data source.
  ///
  /// In a production app, this would be accessed via a Bloc/Cubit.
  late final ChatRemoteDataSource _chatSource;

  @override
  void initState() {
    super.initState();
    _chatSource = sl<ChatRemoteDataSource>();
    _addSystemMessage(
      "Hello! I'm your Onboarding Agent. Let's create your personalized "
      'curriculum. What languages do you know?',
    );
  }

  /// Adds a system message to the chat list.
  void _addSystemMessage(String content) {
    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().toString(),
          content: content,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  /// Sends the user's message to the AI agent and awaits a response.
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        Message(
          id: DateTime.now().toString(),
          content: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await _chatSource.sendMessage(text);
      setState(() {
        _messages.add(response);
      });
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
        unawaited(
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: LinearProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Text(message.content),
      ),
    );
  }
}
