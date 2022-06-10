import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/cache/AccountCacheModel.dart';
import '../data/cache/core_database.dart';

part 'favorites_screen_event.dart';

part 'favorites_screen_state.dart';

class FavoritesScreenBloc
    extends Bloc<FavoritesScreenEvent, FavoritesScreenState> {
  late CoreDatabase database;

  FavoritesScreenBloc() : super(FavoritesScreenInitial()) {
    $FloorCoreDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;
    });


    on<OnEnterScreen>((event, emit) async {
      var data = await database.cacheDao.getAll();
      emit(OnEnterScreenState(data));
    });
  }
}
