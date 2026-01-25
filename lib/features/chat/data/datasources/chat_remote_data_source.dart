import 'package:glotist_app/features/chat/domain/entities/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Interface for remote chat data operations.
abstract class ChatRemoteDataSource {
  /// Sends a message to the remote chat service.
  Future<Message> sendMessage(String content);
}

/// Implementation of [ChatRemoteDataSource] using Gemini AI.
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  /// Creates a [ChatRemoteDataSourceImpl] instance.
  ChatRemoteDataSourceImpl() {
    // TODO(dev): Securely store and retrieve API Key
    const apiKey = 'YOUR_GEMINI_API_KEY';
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  }

  /// The generative AI model used for chat.
  late final GenerativeModel model;

  @override
  Future<Message> sendMessage(String content) async {
    final chat = model.startChat();
    final response = await chat.sendMessage(Content.text(content));

    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: response.text ?? "I couldn't understand that.",
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}
