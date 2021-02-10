import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/no_params.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/entities/player_params.dart';
import 'package:chinchon_counter/domain/usecases/create_player.dart';
import 'package:chinchon_counter/domain/usecases/get_players.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final CreatePlayer createPlayer;
  final GetPlayers getPlayers;

  PlayerBloc({@required this.createPlayer, @required this.getPlayers})
      : super(PlayerInitial());

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is CreatePlayerEvent) {
      yield PlayerLoading();
      Either<AppError, bool> createEither =
          await createPlayer(PlayerParams(playerEntity: event.playerEntity));
      yield createEither.fold((l) => PlayerError(AppError(AppErrorType.dba)),
          (r) => LoadPlayers());
    } else if (event is EditPlayerEvent) {
    } else if (event is DeletePlayerEvent) {
    } else if (event is GetPlayerEvent) {
    } else if (event is GetPlayersEvent) {
      yield PlayerLoading();
      Either<AppError, List<PlayerEntity>> playersEither =
          await getPlayers(NoParams());
      yield playersEither.fold((l) => PlayerError(AppError(AppErrorType.dba)),
          (r) => AllPlayerLoaded(r));
    }
  }
}
