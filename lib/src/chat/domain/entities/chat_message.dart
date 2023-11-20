import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  const ChatMessage({required this.content, required this.isUserMessage});

  const ChatMessage.empty()
      : this(content: 'empty_content', isUserMessage: false);

  final String content;
  final bool isUserMessage;

  @override
  List<Object?> get props => [content, isUserMessage];
}
