import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/entities/player_params.dart';
import 'package:chinchon_counter/domain/usecases/edit_player.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'edit_player_event.dart';
part 'edit_player_state.dart';

class EditPlayerBloc extends Bloc<ModifyPlayerEvent, EditPlayerState> {
  final EditPlayer editPlayer;

  EditPlayerBloc({@required this.editPlayer})
      : super(EditPlayerState(color: Colors.white.value));

  @override
  Stream<EditPlayerState> mapEventToState(
    ModifyPlayerEvent event,
  ) async* {
    if (event is ChangePlayerNameEvent) {
      yield state.copyWith(name: event.name, status: EditPlayerStatus.initial);
    } else if (event is ChangePlayerColorEvent) {
      yield state.copyWith(color: event.color, status: EditPlayerStatus.initial);
    } else if (event is EditPlayerEvent) {
      yield state.copyWith(status: EditPlayerStatus.loading);
      PlayerEntity playerEntity = PlayerEntity(id: event.playerId, name: state.name, color: state.color);
      Either<AppError, bool> editEither =
          await editPlayer(PlayerParams(playerEntity: playerEntity));
      yield editEither.fold((l) => state.copyWith(appEror: l, status: EditPlayerStatus.error),
          (r) => state.copyWith(status: EditPlayerStatus.edited));
    }
  }
}
