part of 'favorites_screen_bloc.dart';

@immutable
abstract class FavoritesScreenState {}

class FavoritesScreenInitial extends FavoritesScreenState {}

class OnEnterScreenState extends FavoritesScreenState {
  List<AccountCacheModel> accounts;

  OnEnterScreenState(this.accounts);
  
}
