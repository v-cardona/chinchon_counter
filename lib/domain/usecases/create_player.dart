import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_params.dart';
import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:chinchon_counter/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class CreatePlayer extends UseCase<bool, PlayerParams> {
  final GameRepository gameRepository;

  CreatePlayer(this.gameRepository);

  @override
  Future<Either<AppError, bool>> call(params) async {
        return await gameRepository.createPlayer(params.playerEntity);
  }
}
