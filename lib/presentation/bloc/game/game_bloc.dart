import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/common/constants/game_constants.dart';
import 'package:chinchon_counter/common/constants/math_constants.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/when_finish_game/when_finish_game_bloc.dart';
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
      List<int> lifesLostAt =
          List.filled(event.players.length, MathConstants.max_int);
      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          initialLifes: event.lifes,
          actualSet: 0,
          actualHand: 0,
          croupier: event.croupier,
          players: event.players,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          lifes: lifes,
          lifesLostAt: lifesLostAt,
          whenFinishGame: event.whenFinishGame,
          status: GameStatus.loaded);
    } else if (event is AddPointsHand) {
      List<List<int>> pointsActualSet = state.pointsActualSet;
      pointsActualSet.add(event.points);

      List<List<int>> pointsSets = state.pointsSets;

      for (int i = 0; i < pointsSets[state.actualSet].length; i++) {
        pointsSets[state.actualSet][i] += event.points[i];
      }

      int croupier = _checkCroupier(state.croupier + 1);

      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          actualHand: state.actualHand + 1,
          croupier: croupier,
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
      yield* _checkSetFinished();
    } else if (event is NextSet) {
      yield* _checkGameFinished();
    } else if (event is FinisheGameEvent) {
      yield* _gameFinished();
    }
  }

  int _checkCroupier(newCroupier) {
    int croupier = newCroupier % state.players.length;

    while (state.lifes[croupier] == GameConstants.dead_player) {
      croupier = (croupier + 1) % state.players.length;
    }

    return croupier;
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

  Stream<GameState> _checkGameFinishedFirstDead() async* {
    List<int> pointsSet = state.pointsSets[state.actualSet];
    List<int> lifes = state.lifes;
    PlayerEntity loser;
    PlayerEntity winner;
    int maxPointsSet = 0;
    int maxLifes = 0;
    double minPointsSet = double.maxFinite;
    bool gameFinished = false;

    for (int i = 0; i < lifes.length; i++) {
      if (GameConstants.lifes_lost == lifes[i]) {
        gameFinished = true;
        if (maxPointsSet <= pointsSet[i]) {
          loser = state.players[i];
          maxPointsSet = pointsSet[i];
        }
      }

      if (maxLifes < lifes[i]) {
        winner = state.players[i];
        minPointsSet = pointsSet[i].toDouble();
        maxLifes = lifes[i];
      } else if (maxLifes == lifes[i] && pointsSet[i] <= minPointsSet) {
        winner = state.players[i];
        minPointsSet = pointsSet[i].toDouble();
        maxLifes = lifes[i];
      }
    }

    if (gameFinished) {
      yield state.copyWith(
          loser: loser,
          winner: winner,
          nUpdates: state.nUpdates + 1,
          status: GameStatus.finishedGame);
    } else {
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

  Stream<GameState> _checkGameFinishedLastDead() async* {
    List<int> pointsSet = state.pointsSets[state.actualSet];
    List<int> lifes = state.lifes;
    List<int> lifesLostAt = state.lifesLostAt;
    PlayerEntity loser;
    PlayerEntity winner;
    int maxPointsSet = 0;
    int maxLifes = 0;
    double minPointsSet = double.maxFinite;
    bool gameFinished = false;
    bool loserFound = false;

    for (int i = 0; i < lifes.length; i++) {
      if (!state.loserFound &&
          GameConstants.lifes_lost == lifes[i] &&
          maxPointsSet <= pointsSet[i]) {
        loser = state.players[i];
        maxPointsSet = pointsSet[i];
        loserFound = true;
      }

      if (maxLifes < lifes[i]) {
        winner = state.players[i];
        minPointsSet = pointsSet[i].toDouble();
        maxLifes = lifes[i];
      } else if (maxLifes == lifes[i] && pointsSet[i] <= minPointsSet) {
        winner = state.players[i];
        minPointsSet = pointsSet[i].toDouble();
        maxLifes = lifes[i];
      }
    }

    for (int i = 0; i < lifes.length; i++) {
      if (lifes[i] == GameConstants.lifes_lost) {
        lifes[i] = GameConstants.dead_player;
        lifesLostAt[i] = state.actualSet;
      }
    }

    int croupier = _checkCroupier(state.croupier);

    try {
      lifes.singleWhere((element) => element > 0);
      gameFinished = true;
    } on StateError {
      if (lifes.every((element) => element == GameConstants.dead_player)) {
        gameFinished = true;
      }
    }

    if (gameFinished) {
      yield state.copyWith(
          winner: winner,
          nUpdates: state.nUpdates + 1,
          loser: loserFound ? loser : state.loser,
          loserFound:
              !state.loserFound && loserFound ? loserFound : state.loserFound,
          lifes: lifes,
          croupier: croupier,
          status: GameStatus.finishedGame);
    } else {
      List<int> pointsSetsInitial = List.filled(state.players.length, 0);
      List<List<int>> pointsSets = state.pointsSets;
      List<List<int>> pointsActualSet = [];
      pointsSets.add(pointsSetsInitial);

      yield state.copyWith(
          nUpdates: state.nUpdates + 1,
          pointsActualSet: pointsActualSet,
          pointsSets: pointsSets,
          actualSet: state.actualSet + 1,
          loser: !state.loserFound && loserFound ? loser : state.loser,
          loserFound:
              !state.loserFound && loserFound ? loserFound : state.loserFound,
          lifes: lifes,
          croupier: croupier,
          status: GameStatus.loaded);
    }
  }

  Stream<GameState> _checkGameFinished() async* {
    switch (state.whenFinishGame) {
      case WhenFinishGameOptions.lastDead:
        yield* _checkGameFinishedLastDead();
        break;
      case WhenFinishGameOptions.firstDead:
        yield* _checkGameFinishedFirstDead();
        break;
      default:
    }
  }

  Stream<GameState> _gameFinished() async* {
    List<int> lifes = state.lifes;
    PlayerEntity loser;
    PlayerEntity winner;
    int maxPointsSet = 0;
    int maxLifes = 0;
    int minLifes = GameConstants.max_lifes;
    double minPointsSet = double.maxFinite;
    List<int> pointsSet = state.pointsSets[state.actualSet];

    if (pointsSet.every((element) => element == 0) && 0 < state.actualSet) {
      pointsSet = state.pointsSets[state.actualSet - 1];
    }

    for (int i = 0; i < lifes.length; i++) {
      if (lifes[i] < minLifes) {
        loser = state.players[i];
        maxPointsSet = pointsSet[i];
        minLifes = lifes[i];
      } else if (lifes[i] == minLifes && maxPointsSet <= pointsSet[i]) {
        loser = state.players[i];
        maxPointsSet = pointsSet[i];
        minLifes = lifes[i];
      }

      if (maxLifes < lifes[i]) {
        winner = state.players[i];
        minPointsSet = pointsSet[i].toDouble();
        maxLifes = lifes[i];
      } else if (maxLifes == lifes[i] && pointsSet[i] <= minPointsSet) {
        winner = state.players[i];
        minPointsSet = pointsSet[i].toDouble();
        maxLifes = lifes[i];
      }
    }

    yield state.copyWith(
        loser: loser,
        winner: winner,
        nUpdates: state.nUpdates + 1,
        status: GameStatus.finishedGame);
  }
}
