import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/color_params.dart';
import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:chinchon_counter/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class CheckIfAvailableColor extends UseCase<bool, ColorParams> {
  final GameRepository gameRepository;

  CheckIfAvailableColor(this.gameRepository);
  
  @override
  Future<Either<AppError, bool>> call(params) async {
    return await gameRepository.checkIfColorIsAvailable(params.color);
  }

}