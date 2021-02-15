import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/no_params.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/usecases/get_players.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetPlayers getPlayers;

  PlayerBloc({@required this.getPlayers}) : super(InitialState());

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is GetAllPlayersEvent) {
      yield LoadingPlayerState();
      Either<AppError, List<PlayerEntity>> playersEither =
          await getPlayers(NoParams());
      yield playersEither.fold((l) => ErrorPlayerState(error: l),
          (r) => LoadedAllPlayers(playersList: r));
    }
  }
}
