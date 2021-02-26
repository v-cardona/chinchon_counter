part of 'game_bloc.dart';

class GameState extends Equatable {
  final int nUpdates; // necesario para indicar el cambio de estado
  final int initialLifes;
  final int actualHand;
  final int actualSet;
  final List<PlayerEntity> players;
  final List<PlayerEntity> lostLifesPlayers;
  final List<List<int>> pointsActualSet;
  final List<List<int>> pointsSets;
  final List<int> lifes;
  final PlayerEntity loser;
  final PlayerEntity winner;
  final GameStatus status;

  const GameState(
      {this.nUpdates = 0,
      this.initialLifes,
      this.actualSet,
      this.actualHand,
      this.players,
      this.lostLifesPlayers,
      this.pointsActualSet,
      this.pointsSets,
      this.lifes,
      this.loser,
      this.winner,
      this.status = GameStatus.initial});

  @override
  List<Object> get props => [
        nUpdates,
        initialLifes,
        actualHand,
        actualSet,
        players,
        lostLifesPlayers,
        pointsActualSet,
        pointsSets,
        lifes,
        loser,
        winner,
        status
      ];

  GameState copyWith(
      {int nUpdates,
      int initialLifes,
      int actualSet,
      int actualHand,
      List<PlayerEntity> players,
      List<PlayerEntity> lostLifesPlayers,
      List<List<int>> pointsActualSet,
      List<List<int>> pointsSets,
      List<int> lifes,
      PlayerEntity loser,
      PlayerEntity winner,
      GameStatus status}) {
    return GameState(
      nUpdates: nUpdates ?? this.nUpdates,
      initialLifes: initialLifes ?? this.initialLifes,
      actualSet: actualSet ?? this.actualSet,
      actualHand: actualHand ?? this.actualHand,
      players: players ?? this.players,
      lostLifesPlayers: lostLifesPlayers ?? this.lostLifesPlayers,
      pointsActualSet: pointsActualSet ?? this.pointsActualSet,
      pointsSets: pointsSets ?? this.pointsSets,
      lifes: lifes ?? this.lifes,
      loser: loser ?? this.loser,
      winner: winner ?? this.winner,
      status: status ?? this.status,
    );
  }
}

enum GameStatus { initial, loading, loaded, finishedSet, finishedGame }
