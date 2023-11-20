import 'package:chatgpt_client/src/chat/data/datasources/choice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_response.g.dart';

@JsonSerializable()
class ChatResponse {
  ChatResponse({required this.choices});

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);
  final List<Choice> choices;

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
