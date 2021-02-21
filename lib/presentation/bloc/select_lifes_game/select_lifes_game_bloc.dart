import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'select_lifes_game_event.dart';
part 'select_lifes_game_state.dart';

class SelectLifesGameBloc
    extends Bloc<SelectLifesGameEvent, SelectLifesGameState> {
  SelectLifesGameBloc() : super(SelectLifesGameInitial());

  @override
  Stream<SelectLifesGameState> mapEventToState(
    SelectLifesGameEvent event,
  ) async* {
    if (event is ToggleSelecLifeEvent) {
      yield ChangedSelectLifesGameState(lifes: event.lifes);
    }
  }
}
