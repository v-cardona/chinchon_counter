import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/no_params.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:chinchon_counter/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class GetPlayers extends UseCase<List<PlayerEntity>, NoParams> {
  final GameRepository gameRepository;

  GetPlayers(this.gameRepository);
  
  @override
  Future<Either<AppError, List<PlayerEntity>>> call(params) async {
    return await gameRepository.getPlayers();
  }

}