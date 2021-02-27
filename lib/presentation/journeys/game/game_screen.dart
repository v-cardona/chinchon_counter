import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/game/puntuation_table_set.dart';
import 'package:chinchon_counter/presentation/journeys/points_hand/points_hand_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatefulWidget {
  final int initialLifes;
  final int croupier;
  final List<PlayerEntity> players;

  const GameScreen(
      {Key key,
      @required this.initialLifes,
      @required this.players,
      this.croupier = 0})
      : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameBloc _gameBloc;

  @override
  void initState() {
    super.initState();
    _gameBloc = getItInstance<GameBloc>();
    _gameBloc.add(InitGameEvent(
        lifes: widget.initialLifes,
        players: widget.players,
        croupier: widget.croupier));
  }

  @override
  void dispose() {
    super.dispose();
    _gameBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.close),
        title: Text(TranslationConstants.appTitle.translate()),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (_) => _gameBloc,
        child: PuntuationTableSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: _gameBloc,
                  child: PointsHandScreen(
                    players: widget.players,
                  ),
                ))),
        child: Icon(Icons.add),
      ),
    );
  }
}
