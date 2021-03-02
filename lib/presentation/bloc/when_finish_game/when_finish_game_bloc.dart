import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'when_finish_game_event.dart';
part 'when_finish_game_state.dart';

class WhenFinishGameBloc
    extends Bloc<WhenFinishGameEvent, WhenFinishGameState> {
  WhenFinishGameBloc() : super(WhenFinishGameInitial());

  @override
  Stream<WhenFinishGameState> mapEventToState(
    WhenFinishGameEvent event,
  ) async* {
    if (event is ToogleWhenFinishEvent) {
      yield WhenFinishGameChanged(whenFinish: event.whenFinish);
    }
  }
}
