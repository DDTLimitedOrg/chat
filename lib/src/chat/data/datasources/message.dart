import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {

  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  final String role;
  final String content;

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
