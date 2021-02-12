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
      : super(PlayerState(color: Colors.white.value));

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is ChangePlayerNameEvent) {
      yield state.copyWith(name: event.name, status: PlayerStatus.initial);
    } else if (event is ChangePlayerColorEvent) {
      yield state.copyWith(color: event.color, status: PlayerStatus.initial);
    } else if (event is CreatePlayerEvent) {
      yield state.copyWith(status: PlayerStatus.loading);
      PlayerEntity playerEntity = PlayerEntity(name: state.name, color: state.color);
      Either<AppError, bool> createEither =
          await createPlayer(PlayerParams(playerEntity: playerEntity));
      yield createEither.fold((l) => state.copyWith(appEror: l, status: PlayerStatus.error),
          (r) => state.copyWith(status: PlayerStatus.created));
    } else if (event is EditPlayerEvent) {
    } else if (event is DeletePlayerEvent) {
    } else if (event is GetPlayerEvent) {
    } else if (event is GetPlayersEvent) {
      yield state.copyWith(status: PlayerStatus.loading);
      Either<AppError, List<PlayerEntity>> playersEither =
          await getPlayers(NoParams());
      yield playersEither.fold((l) => state.copyWith(appEror: l, status: PlayerStatus.error),
          (r) => state.copyWith(playersEntity: r, status: PlayerStatus.playersLoaded));
    }
  }
}
