import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState());

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is InitGameEvent) {
      List<List<int>> pointsActualSet = [
        List.filled(event.players.length, 12),
        List.filled(event.players.length, -10)
      ];
      List<List<int>> pointsSets = [List.filled(event.players.length, 0)];
      List<int> lifes = List.filled(event.players.length, event.lifes);
      yield state.copyWith(
          initialLifes: event.lifes,
          actualSet: 0,
          actualHand: 0,
          players: event.players,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          lifes: lifes,
          status: GameStatus.loaded);
    }
  }
}
