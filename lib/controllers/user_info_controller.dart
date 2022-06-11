import 'package:get/get.dart';
import 'package:git_app/data/api/RemoteDataSource.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';

class FollowersScreenController extends GetxController {
  List<GitAccount>? accounts;

  InfoState state = InfoState.LOADING;

  void getAccountFollowers(String login) async {
    try {
      update();
      var response = await RemoteDataSource().getAccountFollowers(login);
      accounts = response.map((e) => e.toUiModel()).toList();
      state = InfoState.SUCCESS;

      update();
    } catch (e) {
      state = InfoState.ERROR;
      e.printError();
      update();
    }
  }
}

enum InfoState { SUCCESS, LOADING, ERROR }
