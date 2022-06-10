part of 'account_detail_screen_bloc.dart';

@immutable
abstract class AccountDetailScreenEvent {}



class AddToFavoritesEvent extends AccountDetailScreenEvent {
  GitAccount gitAccount;

  AddToFavoritesEvent(this.gitAccount);
}


class OnSelectSingleInformation extends AccountDetailScreenEvent {
  String login;
  OnSelectSingleInformation(this.login);

}
