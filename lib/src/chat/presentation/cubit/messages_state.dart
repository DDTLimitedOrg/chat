import 'package:chatgpt_client/src/chat/data/models/character.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';
import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageListState extends MessageState {
  const MessageListState({required this.character, required this.messages});
  final Character character;
  final List<ChatMessage> messages;

  @override
  List<Object> get props => [character, messages];
}

class MessageProcessingState extends MessageListState {
  const MessageProcessingState({
    required super.character,
    required super.messages,
  });

  @override
  List<Object> get props => super.props..addAll([]);
}

class MessageReadyForInputState extends MessageListState {
  const MessageReadyForInputState({
    required super.character,
    required super.messages,
  });

  MessageReadyForInputState copyWith({
    List<ChatMessage>? toMessages,
    Character? toCharacter,
  }) {
    return MessageReadyForInputState(
      messages: toMessages ?? messages,
      character: toCharacter ?? character,
    );
  }

  @override
  List<Object> get props => super.props..addAll([]);
}

class MessageInitialState extends MessageState {}

class ChatError extends MessageState {
  const ChatError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}

class ChoosingCharacterState extends MessageListState {
  const ChoosingCharacterState({
    required super.character,
    required super.messages,
  });

  @override
  List<Object> get props => super.props..addAll([]);
}
