

import 'package:git_app/data/model/remote/GitAccountResponse.dart';

import '../../cache/AccountCacheModel.dart';

class GitAccount {
  final int? id;
  final String? login;
  final String? realLogin;
  final String? avatarUrl;
  var isFavorite = false;

  GitAccount({required this.id, required this.login,this.realLogin, required this.avatarUrl,required this.isFavorite});

  AccountCacheModel toCacheModel() {
    return AccountCacheModel(id: id, login: login??"", avatarUrl: avatarUrl);
  }

}
