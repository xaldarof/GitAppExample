import 'package:get/get.dart';

import '../data/api/RemoteDataSource.dart';
import '../data/model/ui/GitAccount.dart';

class SearchController extends GetxController {
  List<GitAccount> accounts = [];

  SearchState state = SearchState.INIT;

  var isFirstLoad = true;

  var currentPage = 1;

  void updateCurrentPage() {
    currentPage++;
  }

  void refreshPaging() {
    isFirstLoad = true;
    currentPage = 1;
    accounts.clear();
    update();
  }

  void searchAccount(String login) async {
    try {
      if(isFirstLoad) {
        state = SearchState.LOADING;
      } else {
        state = SearchState.LOADING_MORE_PAGE;
      }
      update();
      var response = await RemoteDataSource().getAccounts(login, currentPage);
      accounts.addAll(response.map((e) => e.toUiModel()).toList());
      state = SearchState.SUCCESS;
      isFirstLoad = false;
      update();
    } catch (e) {
      state = SearchState.ERROR;
      update();
    }
  }
}

enum SearchState { INIT, LOADING, SUCCESS, ERROR, LOADING_MORE_PAGE }
