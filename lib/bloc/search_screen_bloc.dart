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

      on<SearchScreenEvent>((event, emit) async {
        if (event is OnQueryTextChangeEvent) {
          try {
            if (event.query.isNotEmpty) {
              emit(SearchingAccountState());

              var response = await RemoteDataSource().getAccounts(event.query,1);

              // var a = response.map((element) async {
              //   var cache = await database.cacheDao.getById(element.id??1);
              //
              //   return dispatchFavoriteState(cache != null, element.toUiModel());
              // }).toList();

              emit(SuccessSearchResultState(
                  response.map((e) => e.toUiModel()).toList()));
            }
          } catch (e) {
            emit(ErrorState(e as Exception));
          }
        }
      });
    });
  }
}
