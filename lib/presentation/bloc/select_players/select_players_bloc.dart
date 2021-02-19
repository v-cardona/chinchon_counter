import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/common/constants/game_constants.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/no_params.dart';
import 'package:chinchon_counter/domain/entities/player_check_entity.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/usecases/get_players.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'select_players_event.dart';
part 'select_players_state.dart';

class SelectPlayersBloc extends Bloc<SelectPlayersEvent, SelectPlayersState> {
  final GetPlayers getPlayers;

  SelectPlayersBloc({@required this.getPlayers}) : super(SelectPlayersState());

  @override
  Stream<SelectPlayersState> mapEventToState(
    SelectPlayersEvent event,
  ) async* {
    if (event is GetAllPlayersEvent) {
      yield state.copyWith(status: SelectPlayerStatus.loading);
      Either<AppError, List<PlayerEntity>> playersEither =
          await getPlayers(NoParams());
      yield playersEither.fold(
          (l) => state.copyWith(status: SelectPlayerStatus.error, appError: l),
          (r) {
        List<PlayerCheckEntity> playersCheck = [];
        r.forEach((playerEntity) {
          playersCheck.add(PlayerCheckEntity.fromPlayerEntity(playerEntity));
        });
        return state.copyWith(
            players: playersCheck, status: SelectPlayerStatus.loaded);
      });
    } else if (event is RefreshPlayersEvent) {
      yield state.copyWith(status: SelectPlayerStatus.loaded);
    } else if (event is ToggleSelectPlayerEvent) {
      yield state.copyWith(status: SelectPlayerStatus.loading);
      List<PlayerCheckEntity> playersCheck = state.players;
      int index =
          playersCheck.indexWhere((element) => element.id == event.playerId);
      playersCheck[index].selected = event.value;
      yield state.copyWith(
          players: playersCheck, status: SelectPlayerStatus.loaded);
    } else if (event is SaveSelectedPlayersEvent) {
      List<PlayerCheckEntity> playersSelected =
          state.players.where((element) => element.selected).toList();
      if (playersSelected.length < GameConstants.min_players) {
        yield state.copyWith(
            status: SelectPlayerStatus.errorGameOptions,
            appError: AppError(AppErrorType.minPlayers));
      } else if (playersSelected.length > GameConstants.max_players) {
        yield state.copyWith(
            status: SelectPlayerStatus.errorGameOptions,
            appError: AppError(AppErrorType.maxPlayers));
      } else {
        yield state.copyWith(
            selectedPlayers: playersSelected,
            status: SelectPlayerStatus.selectedPlayers);
      }
    }
  }
}
