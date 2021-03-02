import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/when_finish_game/when_finish_game_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/game/puntuation_table_set.dart';
import 'package:chinchon_counter/presentation/journeys/points_hand/points_hand_screen.dart';
import 'package:chinchon_counter/presentation/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreen extends StatefulWidget {
  final int initialLifes;
  final int croupier;
  final WhenFinishGameOptions whenFinishGame;
  final List<PlayerEntity> players;

  const GameScreen(
      {Key key,
      @required this.initialLifes,
      @required this.players,
      @required this.whenFinishGame,
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
        whenFinishGame: widget.whenFinishGame,
        croupier: widget.croupier));
  }

  @override
  void dispose() {
    super.dispose();
    _gameBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _onWillPop,
            icon: Icon(Icons.close),
          ),
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
      ),
    );
  }

  Future<bool> _onWillPop() async {
    await showDialog(
        context: context,
        child: AlertDialogWidget(
            title: TranslationConstants.finishGame.translate(),
            content: TranslationConstants.finishGameConfirm.translate(),
            onPressedYes: () {
              _gameBloc.add(FinisheGameEvent());
              Navigator.of(context).pop();
            }));
    return false;
  }
}
