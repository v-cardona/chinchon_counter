part of 'game_bloc.dart';

class GameState extends Equatable {
  final int nUpdates; // necesario para indicar el cambio de estado
  final int initialLifes;
  final int actualHand;
  final int croupier;
  final int actualSet;
  final List<PlayerEntity> players;
  final List<PlayerEntity> lostLifesPlayers;
  final List<List<int>> pointsActualSet;
  final List<List<int>> pointsSets;
  final List<int> lifes;
  final PlayerEntity loser;
  final bool loserFound;
  final PlayerEntity winner;
  final WhenFinishGameOptions whenFinishGame;
  final GameStatus status;

  const GameState(
      {this.nUpdates = 0,
      this.initialLifes,
      this.actualSet,
      this.actualHand,
      this.croupier,
      this.players,
      this.lostLifesPlayers,
      this.pointsActualSet,
      this.pointsSets,
      this.lifes,
      this.loser,
      this.loserFound = false,
      this.winner,
      this.whenFinishGame,
      this.status = GameStatus.initial});

  @override
  List<Object> get props => [
        nUpdates,
        initialLifes,
        actualHand,
        croupier,
        actualSet,
        players,
        lostLifesPlayers,
        pointsActualSet,
        pointsSets,
        lifes,
        loser,
        loserFound,
        winner,
        whenFinishGame,
        status
      ];

  GameState copyWith(
      {int nUpdates,
      int initialLifes,
      int actualSet,
      int actualHand,
      int croupier,
      List<PlayerEntity> players,
      List<PlayerEntity> lostLifesPlayers,
      List<List<int>> pointsActualSet,
      List<List<int>> pointsSets,
      List<int> lifes,
      PlayerEntity loser,
      bool loserFound,
      PlayerEntity winner,
      WhenFinishGameOptions whenFinishGame,
      GameStatus status}) {
    return GameState(
      nUpdates: nUpdates ?? this.nUpdates,
      initialLifes: initialLifes ?? this.initialLifes,
      actualSet: actualSet ?? this.actualSet,
      actualHand: actualHand ?? this.actualHand,
      croupier: croupier ?? this.croupier,
      players: players ?? this.players,
      lostLifesPlayers: lostLifesPlayers ?? this.lostLifesPlayers,
      pointsActualSet: pointsActualSet ?? this.pointsActualSet,
      pointsSets: pointsSets ?? this.pointsSets,
      lifes: lifes ?? this.lifes,
      loser: loser ?? this.loser,
      loserFound: loserFound ?? this.loserFound,
      winner: winner ?? this.winner,
      whenFinishGame: whenFinishGame ?? this.whenFinishGame,
      status: status ?? this.status,
    );
  }
}

enum GameStatus { initial, loading, loaded, finishedSet, finishedGame }
