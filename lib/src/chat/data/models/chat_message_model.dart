import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel(
      {required super.content, required super.isUserMessage,});

  Map<String, String> toMap() {
    return {
      'role': isUserMessage ? 'user' : 'assistant',
      'content': content,
    };
  }
}
