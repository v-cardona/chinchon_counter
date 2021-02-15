part of 'create_player_bloc.dart';

abstract class CreatePlayerEvent extends Equatable {
  const CreatePlayerEvent();

  @override
  List<Object> get props => [];
}

class ChangePlayerNameEvent extends CreatePlayerEvent {
  final String name;

  ChangePlayerNameEvent({ @required this.name});

  @override
  List<Object> get props => [name];
}

class ChangePlayerColorEvent extends CreatePlayerEvent {
  final int color;

  ChangePlayerColorEvent({@required this.color});

  @override
  List<Object> get props => [color];
}

class AddPlayerEvent extends CreatePlayerEvent {}
