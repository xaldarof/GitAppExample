part of 'search_screen_bloc.dart';

@immutable
abstract class SearchScreenEvent {}

class OnQueryTextChangeEvent extends SearchScreenEvent {
  String query;

  OnQueryTextChangeEvent({required this.query});
}

class AddToFavoritesEvent extends SearchScreenEvent {
  GitAccount gitAccount;

  AddToFavoritesEvent(this.gitAccount);
}

class OnSelectSingleInformation extends SearchScreenEvent {
  String login;
  OnSelectSingleInformation(this.login);

}