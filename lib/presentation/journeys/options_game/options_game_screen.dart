import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/select_lifes_game/select_lifes_game_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/options_game/options_game_lifes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionsGameScreen extends StatefulWidget {
  final List<PlayerEntity> playersSelected;

  const OptionsGameScreen({Key key, @required this.playersSelected})
      : super(key: key);

  @override
  _OptionsGameScreenState createState() => _OptionsGameScreenState();
}

class _OptionsGameScreenState extends State<OptionsGameScreen> {
  SelectLifesGameBloc _selectLifesGameBloc;

  @override
  void initState() {
    super.initState();
    _selectLifesGameBloc = getItInstance<SelectLifesGameBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _selectLifesGameBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.optionsGame.translate()),
      ),
      body: BlocProvider(
          create: (context) => _selectLifesGameBloc, child: OptionsGameLifes()),
    );
  }
}
