import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class GameRepository {
  
  Future<Either<AppError, List<PlayerEntity>>> getPlayers();
  Future<Either<AppError, PlayerEntity>> getPlayer(int playerId);
  Future<Either<AppError, bool>> createPlayer(PlayerEntity playerEntity);
  Future<Either<AppError, bool>> deletePlayer(int playerId);
  Future<Either<AppError, bool>> editPlayer(PlayerEntity playerEntity);
  Future<Either<AppError, bool>> checkIfColorIsAvailable(Color color);
}