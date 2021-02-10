import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/all_players/all_players_list_widget.dart';
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
    _playerBloc.add(GetPlayersEvent());
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
          title: Text(TranslationConstants.players),
        ),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
        body: BlocProvider<PlayerBloc>.value(
          value: _playerBloc,
          child: BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, state) {
              if (state is PlayerError) {
                return Container(
                  child: Text('error'),
                );
              } else if (state is AllPlayerLoaded) {
                List<PlayerEntity> playersList = state.playersEntity;
                if (playersList.isEmpty) {
                  return Center(
                    child: Text(
                      TranslationConstants.noPlayers.translate(context),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                } else {
                  return AllPlayersList(playersList: playersList);
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
