import 'package:chatgpt_client/core/usecase/usecase.dart';
import 'package:chatgpt_client/core/utils/typedef.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';
import 'package:chatgpt_client/src/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class CompleteChat extends UsecaseWithParams<void, CompleteChatParams> {
  const CompleteChat(this._repository);

  final ChatRepository _repository;

  @override
  ResultFuture<String> call(CompleteChatParams params) async =>
      _repository.completeChat(messages: params.messages);
}

class CompleteChatParams extends Equatable {
  const CompleteChatParams({required this.messages});

  const CompleteChatParams.empty()
      : this(messages: const [ChatMessage.empty()]);
  final List<ChatMessage> messages;

  @override
  List<Object?> get props => [messages];
}
