import 'package:chinchon_counter/data/data_sources/players_local_data_source.dart';
import 'package:chinchon_counter/data/tables/player_table.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';

import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:dartz/dartz.dart';

class GameRepositoryImpl extends GameRepository {
  final PlayersLocalDataSource localDataSource;

  GameRepositoryImpl(this.localDataSource);

  @override
  Future<Either<AppError, int>> createPlayer(PlayerEntity playerEntity) async {
    try {
      if (playerEntity.name.isEmpty) {
        return Left(AppError(AppErrorType.nameEmpty));
      }
      List<int> colors = await localDataSource.getColorsPlayers();
      if (colors.contains(playerEntity.color)) {
        return Left(AppError(AppErrorType.colorNotAvailable));
      }
      PlayerTable playerTable = PlayerTable.fromPlayerEntity(playerEntity);
      int playerId = await localDataSource.createPlayer(playerTable);
      return Right(playerId);
    } on Exception {
      return Left(AppError(AppErrorType.dba));
    }
  }

  @override
  Future<Either<AppError, bool>> deletePlayer(int playerId) async {
    try {
      await localDataSource.deletePlayer(playerId);
      return Right(true);
    } on Exception {
      return Left(AppError(AppErrorType.dba));
    }
  }

  @override
  Future<Either<AppError, bool>> editPlayer(PlayerEntity playerEntity) async {
    try {
      PlayerTable playerTable = PlayerTable.fromPlayerEntity(playerEntity);
      await localDataSource.editPlayer(playerTable);
      return Right(true);
    } on Exception {
      return Left(AppError(AppErrorType.dba));
    }
  }

  @override
  Future<Either<AppError, List<PlayerEntity>>> getPlayers() async {
    try {
      List<PlayerTable> players = await localDataSource.getPlayers();
      return Right(players);
    } on Exception {
      return Left(AppError(AppErrorType.dba));
    }
  }
}
