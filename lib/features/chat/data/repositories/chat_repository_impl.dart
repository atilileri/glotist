import 'package:glotist_app/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:glotist_app/features/chat/domain/entities/message.dart';
import 'package:glotist_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this.remoteDataSource);
  final ChatRemoteDataSource remoteDataSource;

  @override
  Future<void> sendMessage(String content) async {
    await remoteDataSource.sendMessage(content);
  }

  @override
  Stream<List<Message>> getMessages(String chatId) {
    // TODO(dev): Implement getting messages from storage/stream
    return Stream.value([]);
  }
}
