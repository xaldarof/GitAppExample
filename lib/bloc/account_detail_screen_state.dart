part of 'account_detail_screen_bloc.dart';

@immutable
abstract class AccountDetailScreenState {}

class AccountDetailScreenInitial extends AccountDetailScreenState {}




class LoadingSingleAccountInformationState extends AccountDetailScreenInitial {

}
class LoadedSingleAccountInformationState extends AccountDetailScreenInitial {
  GitAccount account;

  LoadedSingleAccountInformationState(this.account);
}



class AddedToFavoritesState extends AccountDetailScreenState {
}
