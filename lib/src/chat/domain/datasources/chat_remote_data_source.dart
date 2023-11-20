import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';

abstract class ChatRemoteDataSource {
  Future<String> completeChat({required List<ChatMessage> messages});
}
