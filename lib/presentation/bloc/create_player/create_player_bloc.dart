import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/entities/player_params.dart';
import 'package:chinchon_counter/domain/usecases/create_player.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'create_player_event.dart';
part 'create_player_state.dart';

class CreatePlayerBloc extends Bloc<CreatePlayerEvent, CreatePlayerState> {
  final CreatePlayer createPlayer;

  CreatePlayerBloc({@required this.createPlayer})
      : super(CreatePlayerState(color: Colors.white.value));

  @override
  Stream<CreatePlayerState> mapEventToState(
    CreatePlayerEvent event,
  ) async* {
    if (event is ChangePlayerNameEvent) {
      yield state.copyWith(name: event.name, status: CreatePlayerStatus.initial);
    } else if (event is ChangePlayerColorEvent) {
      yield state.copyWith(color: event.color, status: CreatePlayerStatus.initial);
    } else if (event is CreatePlayerEvent) {
      yield state.copyWith(status: CreatePlayerStatus.loading);
      PlayerEntity playerEntity = PlayerEntity(name: state.name, color: state.color);
      Either<AppError, int> createEither =
          await createPlayer(PlayerParams(playerEntity: playerEntity));
      yield createEither.fold((l) => state.copyWith(appEror: l, status: CreatePlayerStatus.error),
          (r) => state.copyWith(status: CreatePlayerStatus.created));
    }
  }
}
