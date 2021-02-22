part of 'game_bloc.dart';

class GameState extends Equatable {
  final int initialLifes;
  final int actualHand;
  final int actualSet;
  final List<PlayerEntity> players;
  final List<List<int>> pointsActualSet;
  final List<List<int>> pointsSets;
  final List<int> lifes;
  final GameStatus status;

  const GameState(
      {this.initialLifes,
      this.actualSet,
      this.actualHand,
      this.players,
      this.pointsActualSet,
      this.pointsSets,
      this.lifes,
      this.status = GameStatus.initial});

  @override
  List<Object> get props => [
        initialLifes,
        actualHand,
        actualSet,
        players,
        pointsActualSet,
        pointsSets,
        lifes,
        status
      ];

  GameState copyWith(
      {int initialLifes,
      int actualSet,
      int actualHand,
      List<PlayerEntity> players,
      List<List<int>> pointsActualSet,
      List<List<int>> pointsSets,
      List<int> lifes,
      GameStatus status}) {
    return GameState(
      initialLifes: initialLifes ?? this.initialLifes,
      actualSet: actualSet ?? this.actualSet,
      actualHand: actualHand ?? this.actualHand,
      players: players ?? this.players,
      pointsActualSet: pointsActualSet ?? this.pointsActualSet,
      pointsSets: pointsSets ?? this.pointsSets,
      lifes: lifes ?? this.lifes,
      status: status ?? this.status,
    );
  }
}

enum GameStatus { initial, loading, loaded, nextHand }
