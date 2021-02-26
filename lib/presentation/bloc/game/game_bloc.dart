import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/common/constants/game_constants.dart';
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
      List<List<int>> pointsActualSet = [];
      List<List<int>> pointsSets = [List.filled(event.players.length, 0)];
      List<int> lifes = List.filled(event.players.length, event.lifes);
      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          initialLifes: event.lifes,
          actualSet: 0,
          actualHand: 0,
          players: event.players,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          lifes: lifes,
          status: GameStatus.loaded);
    } else if (event is AddPointsHand) {
      List<List<int>> pointsActualSet = state.pointsActualSet;
      pointsActualSet.add(event.points);

      List<List<int>> pointsSets = state.pointsSets;
      for (int i = 0; i < pointsSets[state.actualSet].length; i++) {
        pointsSets[state.actualSet][i] += event.points[i];
      }
      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          actualHand: state.actualHand + 1,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          status: GameStatus.loaded);
      yield* _checkSetFinished();
    } else if (event is EditPointsHand) {
      List<List<int>> pointsActualSet = state.pointsActualSet;
      int oldPoints = pointsActualSet[event.indexHand][event.indexPlayer];
      pointsActualSet[event.indexHand][event.indexPlayer] = event.points;

      List<List<int>> pointsSets = state.pointsSets;
      pointsSets[state.actualSet][event.indexPlayer] +=
          event.points - oldPoints;

      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          status: GameStatus.loaded);
    } else if (event is NextSet) {
      List<int> pointsSetsInitial = List.filled(state.players.length, 0);
      List<List<int>> pointsSets = state.pointsSets;
      List<List<int>> pointsActualSet = [];
      pointsSets.add(pointsSetsInitial);

      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          actualSet: state.actualSet + 1,
          status: GameStatus.loaded);
    }
  }

  Stream<GameState> _checkSetFinished() async* {
    List<int> pointsSet = state.pointsSets[state.actualSet];
    List<int> lifes = state.lifes;
    List<PlayerEntity> lostLifesPlayers = [];
    bool setFinished = false;
    for (int i = 0; i < pointsSet.length; i++) {
      if (GameConstants.max_puntuation < pointsSet[i]) {
        setFinished = true;
        lifes[i] -= 1;
        lostLifesPlayers.add(state.players[i]);
      }
    }
    if (setFinished) {
      yield state.copyWith(
          lifes: lifes,
          lostLifesPlayers: lostLifesPlayers,
          nUpdates: state.nUpdates + 1,
          status: GameStatus.finishedSet);
    }
  }
}
