import 'package:chatgpt_client/src/chat/data/datasources/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choice.g.dart';

@JsonSerializable()
class Choice {
  Choice({required this.index, required this.message});

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  final int index;
  final Message message;

  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}
