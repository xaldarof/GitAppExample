import 'package:get/get.dart';
import 'package:git_app/data/api/RemoteDataSource.dart';
import 'package:git_app/data/model/remote/GitRepositoryResponse.dart';
import 'package:git_app/data/model/ui/GitAccount.dart';


class RepositoriesController extends GetxController {
  List<GitRepositoryResponse>? accounts;

  ReposState state = ReposState.LOADING;

  void getAccountRepos(String login) async {
    try {
      update();
      var response = await RemoteDataSource().getAccountRepos(login);
      accounts = response;
      state = ReposState.SUCCESS;
      update();

    } catch (e) {
      e.printError();
      state = ReposState.ERROR;
      update();
    }
  }
}

enum ReposState { SUCCESS, LOADING, ERROR }
