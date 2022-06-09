import 'package:floor/floor.dart';
import 'package:git_app/data/model/remote/GitAccountResponse.dart';

@entity
class AccountCacheModel {
  @PrimaryKey()
  final int? id;
  final String login;
  final String? avatarUrl;

  AccountCacheModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
  });
}
