part of 'search_screen_bloc.dart';

@immutable
abstract class SearchScreenEvent {}

class OnQueryTextChangeEvent extends SearchScreenEvent {
  String query;

  OnQueryTextChangeEvent({required this.query});
}
