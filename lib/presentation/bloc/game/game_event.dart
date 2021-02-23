part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class InitGameEvent extends GameEvent {
  final int lifes;
  final List<PlayerEntity> players;

  InitGameEvent({@required this.lifes, @required this.players});

  @override
  List<Object> get props => [lifes, players];
}

class AddPointsHand extends GameEvent {
  final List<int> points;

  AddPointsHand({@required this.points});

  @override
  List<Object> get props => [points];
}
