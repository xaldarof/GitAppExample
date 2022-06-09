import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'core_screen_event.dart';

part 'core_screen_state.dart';

class CoreScreenBloc extends Bloc<CoreScreenEvent, CoreScreenState> {

  CoreScreenBloc() : super(CoreScreenInitial()) {
    on<CoreScreenEvent>((event, emit) {

    });
  }
}
