import 'package:chinchon_counter/data/data_sources/players_local_data_source.dart';
import 'package:chinchon_counter/data/repositories/game_repository_impl.dart';
import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:chinchon_counter/domain/usecases/check_available_color.dart';
import 'package:chinchon_counter/domain/usecases/create_player.dart';
import 'package:chinchon_counter/domain/usecases/delete_player.dart';
import 'package:chinchon_counter/domain/usecases/edit_player.dart';
import 'package:chinchon_counter/domain/usecases/get_player.dart';
import 'package:chinchon_counter/domain/usecases/get_players.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future init() async {
  // data sources
  getItInstance.registerLazySingleton<PlayersLocalDataSource>(
      () => PlayersLocalDataSourceImpl());

  // game repository
  getItInstance.registerLazySingleton<GameRepository>(
      () => GameRepositoryImpl(getItInstance()));

  // init usecases
  getItInstance.registerLazySingleton<CheckIfAvailableColor>(
      () => CheckIfAvailableColor(getItInstance()));
  getItInstance
      .registerLazySingleton<CreatePlayer>(() => CreatePlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<DeletePlayer>(() => DeletePlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<EditPlayer>(() => EditPlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPlayer>(() => GetPlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPlayers>(() => GetPlayers(getItInstance()));

  // blocs
  getItInstance.registerLazySingleton(() =>
      PlayerBloc(createPlayer: getItInstance(), getPlayers: getItInstance()));
}
