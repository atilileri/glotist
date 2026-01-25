import 'package:glotist_app/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String content);
  Stream<List<Message>> getMessages(String chatId);
}
