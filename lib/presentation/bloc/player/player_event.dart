part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class CreatePlayerEvent extends PlayerEvent {
  final PlayerEntity playerEntity;

  CreatePlayerEvent(this.playerEntity);

  @override
  List<Object> get props => [playerEntity];
}

class EditPlayerEvent extends PlayerEvent {
  final PlayerEntity playerEntity;

  EditPlayerEvent(this.playerEntity);

  @override
  List<Object> get props => [playerEntity];
}


class DeletePlayerEvent extends PlayerEvent {
  final int playerId;

  DeletePlayerEvent(this.playerId);

  @override
  List<Object> get props => [playerId];
}


class GetPlayerEvent extends PlayerEvent {
  final int playerId;

  GetPlayerEvent(this.playerId);

  @override
  List<Object> get props => [playerId];
}

class GetPlayersEvent extends PlayerEvent {}
