import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/app_error_extension.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/all_players/all_players_list_widget.dart';
import 'package:chinchon_counter/presentation/journeys/create_player/create_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPlayersScreen extends StatefulWidget {
  const AllPlayersScreen({Key key}) : super(key: key);

  @override
  _AllPlayersScreenState createState() => _AllPlayersScreenState();
}

class _AllPlayersScreenState extends State<AllPlayersScreen> {
  PlayerBloc _playerBloc;

  @override
  void initState() {
    super.initState();
    _playerBloc = getItInstance<PlayerBloc>();
    _playerBloc.add(GetAllPlayersEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _playerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(TranslationConstants.players.translate()),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => CreatePlayerScreen(),
                ))
                .then((value) => _playerBloc.add(GetAllPlayersEvent()));
          },
        ),
        body: BlocProvider<PlayerBloc>.value(
          value: _playerBloc,
          child: BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, state) {
              if (state is ErrorPlayerState) {
                return Container(
                  child: Text(state.error.showError()),
                );
              } else if (state is LoadedAllPlayers) {
                List<PlayerEntity> playersList = state.playersList;
                if (playersList.isEmpty) {
                  return Center(
                    child: Text(
                      TranslationConstants.noPlayers.translate(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return AllPlayersList(playersList: playersList);
                }
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ));
  }
}
