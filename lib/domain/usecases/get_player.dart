import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/entities/player_params.dart';
import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:chinchon_counter/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPlayer extends UseCase<PlayerEntity, PlayerParams> {
  final GameRepository gameRepository;

  GetPlayer(this.gameRepository);
  
  @override
  Future<Either<AppError, PlayerEntity>> call(params) async {
    return await gameRepository.getPlayer(params.playerId);
  }

}