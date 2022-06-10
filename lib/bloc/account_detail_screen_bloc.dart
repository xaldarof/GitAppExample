import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/api/RemoteDataSource.dart';
import '../data/cache/core_database.dart';
import '../data/model/ui/GitAccount.dart';

part 'account_detail_screen_event.dart';

part 'account_detail_screen_state.dart';

class AccountDetailScreenBloc
    extends Bloc<AccountDetailScreenEvent, AccountDetailScreenState> {

  late CoreDatabase database;
  final colorController = StreamController();

  AccountDetailScreenBloc() : super(AccountDetailScreenInitial()) {
    $FloorCoreDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;
    });

    on<OnSelectSingleInformation>((event, emit) async {
      emit(LoadingSingleAccountInformationState());
      var response = await RemoteDataSource().getByLogin(event.login);
      var cacheModel = await database.cacheDao.getById(response.id ?? -1);
      var isExist = cacheModel != null;
      print("LOGIN = ${event.login}");

      emit(LoadedSingleAccountInformationState(GitAccount(
          id: response.id,
          login: response.login ?? "",
          avatarUrl: response.avatarUrl,
          isFavorite: isExist)));

      emit(AddedToFavoritesState());
    });

    on<AddToFavoritesEvent>((event, emit) {
      database.cacheDao.insertUser(event.gitAccount.toCacheModel());
      emit(AddedToFavoritesState());
      colorController.sink.add(true);

    });
  }
}
