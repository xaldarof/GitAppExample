import 'package:json_annotation/json_annotation.dart';

part 'GitRepositoryResponse.g.dart';

@JsonSerializable()
class GitRepositoryResponse {
  int? id;
  String? name;
  @JsonKey(name: 'full_name')
  String? fullName;
  String? description;

  GitRepositoryResponse(
      {required this.id,
      required this.name,
      required this.fullName,
      required this.description});

  factory GitRepositoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GitRepositoryResponseFromJson(json);
}
