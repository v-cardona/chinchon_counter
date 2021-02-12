part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class ChangePlayerNameEvent extends PlayerEvent {
  final String name;

  ChangePlayerNameEvent({ @required this.name});

  @override
  List<Object> get props => [name];
}

class ChangePlayerColorEvent extends PlayerEvent {
  final int color;

  ChangePlayerColorEvent({@required this.color});

  @override
  List<Object> get props => [color];
}

class CreatePlayerEvent extends PlayerEvent {}

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
