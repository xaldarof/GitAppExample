part of 'search_screen_bloc.dart';

@immutable
abstract class SearchScreenState {}

class SearchScreenInitial extends SearchScreenState {}

class SearchingAccountState extends SearchScreenState {
}

class SuccessSearchResultState extends SearchScreenState {
  List<GitAccount> accounts;

  SuccessSearchResultState(this.accounts);
}

class ErrorState extends SearchScreenState {
  Exception exception;

  ErrorState(this.exception);
}


class AddedToFavoritesState extends SearchScreenState {
}


class LoadingSingleAccountInformationState extends SearchScreenState {
  
}
class LoadedSingleAccountInformationState extends SearchScreenState {
  GitAccount account;

  LoadedSingleAccountInformationState(this.account);
}