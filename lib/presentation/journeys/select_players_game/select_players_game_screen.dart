import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/app_error_extension.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_check_entity.dart';
import 'package:chinchon_counter/presentation/bloc/select_players/select_players_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/options_game/options_game_screen.dart';
import 'package:chinchon_counter/presentation/journeys/select_players_game/checkable_player_list_item_widget.dart';
import 'package:chinchon_counter/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPlayersGameScreen extends StatefulWidget {
  const SelectPlayersGameScreen({Key key}) : super(key: key);

  @override
  _SelectPlayersGameScreenState createState() =>
      _SelectPlayersGameScreenState();
}

class _SelectPlayersGameScreenState extends State<SelectPlayersGameScreen> {
  SelectPlayersBloc _selectPlayersBloc;

  @override
  void initState() {
    super.initState();
    _selectPlayersBloc = getItInstance<SelectPlayersBloc>();
    _selectPlayersBloc.add(GetAllPlayersEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _selectPlayersBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(TranslationConstants.selectPlayers.translate()),
        ),
        body: BlocProvider<SelectPlayersBloc>.value(
          value: _selectPlayersBloc,
          child: BlocListener<SelectPlayersBloc, SelectPlayersState>(
            listener: (context, state) {
              // hide previous snackbars
              Scaffold.of(context).hideCurrentSnackBar();

              if (state.status == SelectPlayerStatus.error) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(state.appError.showError()),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red,
                ));
              } else if (state.status == SelectPlayerStatus.selectedPlayers) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OptionsGameScreen(
                    playersSelected: state.selectedPlayers,
                  ),
                )).then((value) => _selectPlayersBloc.add(RefreshPlayersEvent()));
              }
            },
            child: BlocBuilder<SelectPlayersBloc, SelectPlayersState>(
              builder: (context, state) {
                if (state.status == SelectPlayerStatus.loaded) {
                  List<PlayerCheckEntity> playersList = state.players;
                  if (playersList.isEmpty) {
                    return Center(
                      child: Text(
                        TranslationConstants.noPlayers.translate(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: playersList.length,
                            itemBuilder: (BuildContext context, int index) {
                              PlayerCheckEntity player = playersList[index];
                              return CheckablePlayerListItem(player: player);
                            },
                          ),
                        ),
                        Button(
                          onPressed: () => _selectPlayersBloc
                              .add(SaveSelectedPlayersEvent()),
                          text: TranslationConstants.done,
                        )
                      ],
                    );
                  }
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}
