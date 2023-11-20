import 'package:chatgpt_client/src/chat/data/models/character.dart';
import 'package:chatgpt_client/src/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';
import 'package:chatgpt_client/src/chat/domain/usecases/complete_chat.dart';
import 'package:chatgpt_client/src/chat/presentation/cubit/messages_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<MessageState> {
  MessagesCubit({required CompleteChat completeChat})
      : _completeChat = completeChat,
        super(MessageInitialState()) {
    loadMessages().then((value) => characterChanged(1));
  }

  final CompleteChat _completeChat;

  Future<void> loadMessages() async {
    emit(
      MessageReadyForInputState(
        messages: const [],
        character: Character.allCharacters().first,
      ),
    );
  }

  Future<void> addMessage(ChatMessage message) async {
    if (state is MessageReadyForInputState) {
      final state = this.state as MessageReadyForInputState;

      final messages = List<ChatMessage>.from(state.messages)..add(message);
      emit(
        MessageProcessingState(
          messages: messages,
          character: state.character,
        ),
      );

      final response =
          await _completeChat(CompleteChatParams(messages: messages));

      response.fold(
        (failure) => emit(ChatError(failure.errorMessage)),
        (responseMessage) => emit(
          state.copyWith(
            toMessages: messages
              ..add(
                ChatMessage(
                  content: responseMessage,
                  isUserMessage: false,
                ),
              ),
          ),
        ),
      );
    }
  }

  void characterChanged(int index) {
    final newCharacter = Character.allCharacters()[index];

    emit(
      MessageReadyForInputState(messages: const [], character: newCharacter),
    );

    final firstMessage =
        ChatMessageModel(content: newCharacter.pre, isUserMessage: true);
    addMessage(firstMessage);
  }

  void dismissCharacterChanged() {
    if (state is MessageListState) {
      final state = this.state as MessageListState;
      emit(
        MessageReadyForInputState(
          character: state.character,
          messages: state.messages,
        ),
      );
    }
  }

  void chooseCharacterPressed() {
    if (state is MessageListState) {
      final state = this.state as MessageListState;

      emit(
        ChoosingCharacterState(
          character: state.character,
          messages: state.messages,
        ),
      );
    }
  }
}
