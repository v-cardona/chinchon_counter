part of 'edit_player_bloc.dart';

abstract class ModifyPlayerEvent extends Equatable {
  const ModifyPlayerEvent();

  @override
  List<Object> get props => [];
}

class ChangePlayerNameEvent extends ModifyPlayerEvent {
  final String name;

  ChangePlayerNameEvent({@required this.name});

  @override
  List<Object> get props => [name];
}

class ChangePlayerColorEvent extends ModifyPlayerEvent {
  final int color;

  ChangePlayerColorEvent({@required this.color});

  @override
  List<Object> get props => [color];
}

class EditPlayerEvent extends ModifyPlayerEvent {
  final int playerId;

  EditPlayerEvent({@required this.playerId});

  @override
  List<Object> get props => [playerId];
}

class DeletePlayerEvent extends ModifyPlayerEvent {}
