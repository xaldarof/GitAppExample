import 'package:json_annotation/json_annotation.dart';

import '../../cache/AccountCacheModel.dart';

class GitAccount extends JsonSerializable {
  final int? id;
  final String login;
  final String? avatarUrl;
  var isFavorite = false;

  GitAccount(
      {required this.id,
      required this.login,
      required this.avatarUrl,
      required this.isFavorite});

  AccountCacheModel toCacheModel() {
    return AccountCacheModel(id: id, login: login, avatarUrl: avatarUrl);
  }
}

GitAccount dispatchFavoriteState(bool condition, GitAccount gitAccount) {
  var data = GitAccount(
      id: gitAccount.id, login: gitAccount.login, avatarUrl: gitAccount.avatarUrl, isFavorite: condition);
  return data;
}
