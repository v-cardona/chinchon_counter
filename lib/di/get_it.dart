import 'package:chinchon_counter/data/data_sources/players_local_data_source.dart';
import 'package:chinchon_counter/data/repositories/game_repository_impl.dart';
import 'package:chinchon_counter/domain/repositories/game_repository.dart';
import 'package:chinchon_counter/domain/usecases/create_player.dart';
import 'package:chinchon_counter/domain/usecases/delete_player.dart';
import 'package:chinchon_counter/domain/usecases/edit_player.dart';
import 'package:chinchon_counter/domain/usecases/get_players.dart';
import 'package:chinchon_counter/presentation/bloc/create_player/create_player_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/edit_player/edit_player_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/edit_points_hand/edit_points_hand_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/order_players/order_players_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/points_hand/points_hand_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/select_lifes_game/select_lifes_game_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/select_players/select_players_bloc.dart';
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
  getItInstance
      .registerLazySingleton<CreatePlayer>(() => CreatePlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<DeletePlayer>(() => DeletePlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<EditPlayer>(() => EditPlayer(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPlayers>(() => GetPlayers(getItInstance()));

  // blocs
  getItInstance.registerFactory(() => PlayerBloc(getPlayers: getItInstance()));
  getItInstance
      .registerFactory(() => CreatePlayerBloc(createPlayer: getItInstance()));
  getItInstance.registerFactory(() => EditPlayerBloc(
      editPlayer: getItInstance(), deletePlayer: getItInstance()));
  getItInstance.registerFactory(() => SelectPlayersBloc(
        getPlayers: getItInstance(),
      ));
  getItInstance.registerFactory(() => SelectLifesGameBloc());
  getItInstance.registerFactory(() => OrderPlayersBloc());
  getItInstance.registerLazySingleton(() => GameBloc());
  getItInstance.registerFactory(() => PointsHandBloc());
  getItInstance.registerFactory(() => EditPointsHandBloc());
}
