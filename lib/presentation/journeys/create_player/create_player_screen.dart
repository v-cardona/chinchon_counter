import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/app_error_extension.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/presentation/bloc/create_player/create_player_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/create_player/create_player_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlayerScreen extends StatefulWidget {
  const CreatePlayerScreen({Key key}) : super(key: key);

  @override
  _CreatePlayerScreenState createState() => _CreatePlayerScreenState();
}

class _CreatePlayerScreenState extends State<CreatePlayerScreen> {
  CreatePlayerBloc _createPlayerBloc;

  @override
  void initState() {
    super.initState();
    _createPlayerBloc = getItInstance<CreatePlayerBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _createPlayerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.createPlayer.translate()),
      ),
      body: BlocListener(
        cubit: _createPlayerBloc,
        child: BlocProvider(
          create: (_) => _createPlayerBloc,
          child: CreatePlayerForm(),
        ),
        listener: (context, CreatePlayerState state) {
          // hide previous snackbars
          Scaffold.of(context).hideCurrentSnackBar();

          // if fail when login show snackbar fail
          if (state.status == CreatePlayerStatus.error) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(state.appEror.showError()), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
          }

          // if login success emit Logged state to change to homeScreen
          if (state.status == CreatePlayerStatus.created) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
