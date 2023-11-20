import 'package:chatgpt_client/core/errors/exceptions.dart';
import 'package:chatgpt_client/core/errors/failure.dart';
import 'package:chatgpt_client/core/utils/typedef.dart';
import 'package:chatgpt_client/src/chat/domain/datasources/chat_remote_data_source.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';
import 'package:chatgpt_client/src/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImplementation implements ChatRepository {
  const ChatRepositoryImplementation(this._remoteDataSource);

  final ChatRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<String> completeChat({
    required List<ChatMessage> messages,
  }) async {
    try {
      final result = await _remoteDataSource.completeChat(messages: messages);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
