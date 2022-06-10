import 'package:git_app/data/cache/AccountCacheModel.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';

class GitAccountResponse {
  String? login;
  int? id;
  String? avatarUrl;

  GitAccountResponse(
      {required this.id, required this.login, required this.avatarUrl});

  factory GitAccountResponse.fromJson(Map<String, dynamic> json) {
    return GitAccountResponse(
      id: json['id'],
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }

  AccountCacheModel toCacheModel() {
    return AccountCacheModel(id: id, login: login ?? "", avatarUrl: avatarUrl);
  }

  GitAccount toUiModel() {
    return GitAccount(
        id: id,
        login: login??"",
        avatarUrl: avatarUrl,
        isFavorite: false);
  }
}
