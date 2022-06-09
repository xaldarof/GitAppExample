import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:git_app/bloc/core/core_screen_bloc.dart';
import 'package:git_app/data/api/RemoteDataSource.dart';
import 'package:git_app/data/cache/AccountCacheModel.dart';
import 'package:git_app/data/cache/core_database.dart';
import 'package:git_app/data/model/remote/GitAccountResponse.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../data/model/ui/GitAccount.dart';

part 'search_screen_event.dart';

part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  late CoreDatabase database;

  SearchScreenBloc() : super(SearchScreenInitial()) {
    $FloorCoreDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;

      dispatchSearchScreenEvent(database);
      dispatchSingleInformationScreenEvent(database);
      // users = database.userDAO.retrieveUsers();
    });
  }

  void dispatchSingleInformationScreenEvent(CoreDatabase coreDatabase) {
    on<OnSelectSingleInformation>((event, emit) async {
      emit(LoadingSingleAccountInformationState());
      var response = await RemoteDataSource().getByLogin(event.login);

      print("Response = ${response.toString()}");

      emit(LoadedSingleAccountInformationState(response.toUiModel()));
    });
  }

  void dispatchSearchScreenEvent(CoreDatabase coreDatabase) {
    on<SearchScreenEvent>((event, emit) async {
      if (event is OnQueryTextChangeEvent) {
        try {
          emit(SearchingAccountState());

          var response = await RemoteDataSource().getAccounts(event.query);
          List<GitAccount> list = [];

          response.forEach((element) async {
            var cacheModel = await coreDatabase.cacheDao.getById(element.id ?? 1);
            var isExist = cacheModel != null;

            list.add(GitAccount(
                id: element.id,
                login: cacheModel?.login ?? element.login,
                avatarUrl: element.avatarUrl,
                realLogin: element.login,
                isFavorite: isExist));
          });

          emit(SuccessSearchResultState(list));
        } catch (e) {
          emit(ErrorState(e as Exception));
        }
      }

      if (event is AddToFavoritesEvent) {
        coreDatabase.cacheDao.insertUser(event.gitAccount.toCacheModel());
        emit(AddedToFavoritesState());
      }
    });
  }
}
