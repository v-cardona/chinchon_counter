part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class InitGameEvent extends GameEvent {
  final int lifes;
  final int croupier;
  final WhenFinishGameOptions whenFinishGame;
  final List<PlayerEntity> players;

  InitGameEvent(
      {@required this.lifes,
      @required this.players,
      @required this.whenFinishGame,
      this.croupier});

  @override
  List<Object> get props => [lifes, players, whenFinishGame];
}

class AddPointsHand extends GameEvent {
  final List<int> points;

  AddPointsHand({@required this.points});

  @override
  List<Object> get props => [points];
}

class EditPointsHand extends GameEvent {
  final int points;
  final int indexHand;
  final int indexPlayer;

  EditPointsHand(
      {@required this.indexHand,
      @required this.indexPlayer,
      @required this.points});

  @override
  List<Object> get props => [points, indexHand, indexPlayer];
}

class NextSet extends GameEvent {}

class FinisheGameEvent extends GameEvent {}
