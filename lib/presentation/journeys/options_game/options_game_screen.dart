import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/order_players/order_players_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/select_lifes_game/select_lifes_game_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/game/game_screen.dart';
import 'package:chinchon_counter/presentation/journeys/options_game/options_game_lifes.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_players_widget.dart';

class OptionsGameScreen extends StatefulWidget {
  final List<PlayerEntity> playersSelected;

  const OptionsGameScreen({Key key, @required this.playersSelected})
      : super(key: key);

  @override
  _OptionsGameScreenState createState() => _OptionsGameScreenState();
}

class _OptionsGameScreenState extends State<OptionsGameScreen> {
  SelectLifesGameBloc _selectLifesGameBloc;
  OrderPlayersBloc _orderPlayersBloc;

  @override
  void initState() {
    super.initState();
    _selectLifesGameBloc = getItInstance<SelectLifesGameBloc>();
    _orderPlayersBloc = getItInstance<OrderPlayersBloc>();
    _selectLifesGameBloc.add(ToggleSelecLifeEvent(lifes: 1));
    _orderPlayersBloc
        .add(InitOrderPlayerEvent(players: widget.playersSelected));
  }

  @override
  void dispose() {
    super.dispose();
    _selectLifesGameBloc.close();
    _orderPlayersBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.optionsGame.translate()),
      ),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => _selectLifesGameBloc),
            BlocProvider(create: (context) => _orderPlayersBloc)
          ],
          child: Column(
            children: [
              OptionsGameLifes(),
              OrderPlayersWidget(),
              Button(
                  text: TranslationConstants.play,
                  onPressed: () {
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameScreen(),
                      ),
                    );
                  })
            ],
          )),
    );
  }
}
