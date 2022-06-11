import 'package:git_app/data/cache/AccountCacheModel.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GitAccountResponse.g.dart';

@JsonSerializable()
class GitAccountResponse {
  String? login;
  int? id;
  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  GitAccountResponse(
      {required this.id, required this.login, required this.avatarUrl});

  factory GitAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$GitAccountResponseFromJson(json);

  AccountCacheModel toCacheModel() {
    return AccountCacheModel(id: id, login: login ?? "", avatarUrl: avatarUrl);
  }

  GitAccount toUiModel() {
    return GitAccount(
        id: id, login: login ?? "", avatarUrl: avatarUrl, isFavorite: false);
  }
}
