import 'package:chatgpt_client/core/utils/typedef.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';

abstract class ChatRepository {
  ResultFuture<String> completeChat({required List<ChatMessage> messages});
}
