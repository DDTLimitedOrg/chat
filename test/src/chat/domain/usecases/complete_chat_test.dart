import 'package:chatgpt_client/src/chat/domain/repositories/chat_repository.dart';
import 'package:chatgpt_client/src/chat/domain/usecases/complete_chat.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'chat_repository.mock.dart';

void main() {
  late CompleteChat usecase;
  late ChatRepository repository;

  setUp(() {
    repository = MockChatRepository();
    usecase = CompleteChat(repository);
  });

  const params = CompleteChatParams.empty();

  const tResponse = 'test_response';
  test('should call the [ChatRepository.completeChat] method', () async {
    // Arrange
    when(() => repository.completeChat(messages: any(named: 'messages')))
        .thenAnswer((invocation) async => const Right(tResponse));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, String>(tResponse)));
    verify(() => repository.completeChat(messages: params.messages));
    verifyNoMoreInteractions(repository);
  });
}
