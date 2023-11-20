import 'package:chatgpt_client/core/errors/exceptions.dart';
import 'package:chatgpt_client/core/utils/constants.env';
import 'package:chatgpt_client/src/chat/data/datasources/chat_remote_data_source_implementation.dart';
import 'package:chatgpt_client/src/chat/domain/datasources/chat_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late ChatRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = ChatRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('completeChat', () {
    test(
      'should complete successfully when the status code is 200',
      () async {
        when(() => client.post(any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),),).thenAnswer((_) async {
          final json = fixture('complete_chat_response.json');
          return http.Response(json, 200);
        });

        final result = await remoteDataSource.completeChat(messages: []);

        expect(result, equals('Hello! How can I assist you today?'));

        verify(
          () => client.post(Uri.https(kBaseUrl, kCompleteChatEndpoint),
              headers: any(named: 'headers'), body: any(named: 'body'),),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [APIException] when the status code is not 200',
      () async {
        const tMessage = 'Server Down';

        when(() => client.post(any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),),).thenAnswer((_) async {
          return http.Response(tMessage, 500);
        });

        final result = remoteDataSource.completeChat(messages: []);

        expect(
          () => result,
          throwsA(
            const APIException(message: tMessage, statusCode: 500),
          ),
        );

        verify(
          () => client.post(Uri.https(kBaseUrl, kCompleteChatEndpoint),
              headers: any(named: 'headers'), body: any(named: 'body'),),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
