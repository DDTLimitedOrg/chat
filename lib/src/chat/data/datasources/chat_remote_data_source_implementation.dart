import 'dart:convert';

import 'package:chatgpt_client/core/errors/exceptions.dart';
import 'package:chatgpt_client/core/utils/constants.env';
import 'package:chatgpt_client/src/chat/data/datasources/chat_response.dart';
import 'package:chatgpt_client/src/chat/data/models/chat_message_model.dart';
import 'package:chatgpt_client/src/chat/domain/datasources/chat_remote_data_source.dart';
import 'package:chatgpt_client/src/chat/domain/entities/chat_message.dart';
import 'package:http/http.dart' as http;

const kCompleteChatEndpoint = '/v1/chat/completions';

class ChatRemoteDataSrcImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSrcImpl(this._client);

  final http.Client _client;

  static const _model = 'gpt-3.5-turbo';

  @override
  Future<String> completeChat({required List<ChatMessage> messages}) async {
    final encodedMessages = <Map<String, String>>[];

    for (final message in messages) {
      if (message is ChatMessageModel) {
        encodedMessages.add(message.toMap());
      }
    }

    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCompleteChatEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiApiKey',
        },
        body: jsonEncode({
          'model': _model,
          'messages': encodedMessages.toList(),
        }),
      );

      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final chatResponse = ChatResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      if (chatResponse.choices.isEmpty) {
        throw const APIException(
          message: 'no data',
          statusCode: 400,
        );
      }
      return chatResponse.choices.first.message.content.trim();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
