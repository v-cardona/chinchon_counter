part of 'select_players_bloc.dart';

abstract class SelectPlayersEvent extends Equatable {
  const SelectPlayersEvent();

  @override
  List<Object> get props => [];
}

class GetAllPlayersEvent extends SelectPlayersEvent {}

class RefreshPlayersEvent extends SelectPlayersEvent {}

class ToggleSelectPlayerEvent extends SelectPlayersEvent {
  final int playerId;
  final bool value;

  ToggleSelectPlayerEvent({ @required this.playerId, @required this.value});

  @override
  List<Object> get props => [playerId];
}

class SaveSelectedPlayersEvent extends SelectPlayersEvent {}