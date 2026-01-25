import 'package:glotist_app/features/chat/domain/entities/message.dart';

/// Interface for chat repository operations.
abstract class ChatRepository {
  /// Sends a message with the given [content].
  Future<void> sendMessage(String content);

  /// Retrieves a stream of messages for the given [chatId].
  Stream<List<Message>> getMessages(String chatId);
}
