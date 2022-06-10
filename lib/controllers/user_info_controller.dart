import 'package:get/get.dart';
import 'package:git_app/data/api/RemoteDataSource.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';

class UserInfoController extends GetxController {
  GitAccount? account;

  void getAccountInfo(String login) async {
    var response = await RemoteDataSource().getByLogin(login);
    account = response.toUiModel();
    update();
  }

  void updateName() {
    account = GitAccount(
        id: 1, login: "login", avatarUrl: "avatarUrl", isFavorite: false);
    update();
  }
}
