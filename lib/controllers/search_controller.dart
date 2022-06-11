import 'dart:math';

import 'package:get/get.dart';
import 'package:git_app/data/cache/AccountCacheModel.dart';
import 'package:git_app/data/cache/core_database.dart';

import '../data/api/RemoteDataSource.dart';
import '../data/model/ui/GitAccount.dart';

class SearchController extends GetxController {
  List<GitAccount> accounts = [];
  CoreDatabase? coreDatabase;

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
      if (isFirstLoad) {
        state = SearchState.LOADING;
      } else {
        state = SearchState.LOADING_MORE_PAGE;
      }
      update();
      var response = await RemoteDataSource().getAccounts(login, currentPage);
      var mapped = response.map((e) => e.toUiModel()).toList();
      mapped.forEach((element) async {
        element.isFavorite = await coreDatabase?.cacheDao.getById(element.id!) != null;
        update();
      });

      accounts.addAll(mapped);
      state = SearchState.SUCCESS;
      isFirstLoad = false;
      update();
    } catch (e) {
      state = SearchState.ERROR;
      update();
    }
  }

  @override
  void onInit() {
    $FloorCoreDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      coreDatabase = value;
    });
    super.onInit();
  }

  void dispatchAccountState(int index) {
    if (accounts[index].isFavorite) {
      _deleteFromFavorites(index);
    } else {
      _addToFavorites(index);
    }
  }

  void _addToFavorites(int index) {
    coreDatabase?.cacheDao.insertUser(AccountCacheModel(
        id: accounts[index].id,
        login: accounts[index].login,
        avatarUrl: accounts[index].avatarUrl));

    accounts[index].isFavorite = true;
    update();
  }

  void _deleteFromFavorites(int index) {
    coreDatabase?.cacheDao.delete(accounts[index].id! );
    accounts[index].isFavorite = false;
    update();
  }
}

enum SearchState { INIT, LOADING, SUCCESS, ERROR, LOADING_MORE_PAGE }
