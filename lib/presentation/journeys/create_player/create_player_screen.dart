import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/create_player/create_player_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlayerScreen extends StatefulWidget {
  const CreatePlayerScreen({Key key}) : super(key: key);

  @override
  _CreatePlayerScreenState createState() => _CreatePlayerScreenState();
}

class _CreatePlayerScreenState extends State<CreatePlayerScreen> {
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
        title: Text(TranslationConstants.createPlayer),
      ),
      body: BlocProvider.value(
          value: _playerBloc,
          child: BlocListener(
            cubit: _playerBloc,
            child: BlocBuilder<PlayerBloc, PlayerState>(
              cubit: _playerBloc,
              builder: (context, state) {
                return CreatePlayerForm();
              },
            ),
            listener: (context, PlayerState state) {
              // hide previous snackbars
              Scaffold.of(context).hideCurrentSnackBar();

              // if fail when login show snackbar fail
              if (state.status == PlayerStatus.error) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getPlayerError(context, state.appEror),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red,
                ));
              }

              // if login success emit Logged state to change to homeScreen
              if (state.status == PlayerStatus.created) {
                Navigator.of(context).pop();
              }
            },
          )),
    );
  }

  // method to get which error is
  Widget getPlayerError(BuildContext context, AppError appError) {
    String error;
    switch (appError.errorType) {
      case AppErrorType.dba:
        error = TranslationConstants.errorDb.translate(context);
        break;
      case AppErrorType.colorNotAvailable:
        error = TranslationConstants.errorcolorNotAvailable.translate(context);
        break;
      case AppErrorType.nameEmpty:
        error = TranslationConstants.errornameEmpty.translate(context);
        break;
      default:
        error = TranslationConstants.errorMsgGeneral.translate(context);
    }

    return Text(error);
  }
}