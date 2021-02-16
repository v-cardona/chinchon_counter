import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/app_error.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/edit_player/edit_player_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_player_form.dart';

class EditPlayerScreen extends StatefulWidget {
  final PlayerEntity player;

  const EditPlayerScreen({Key key, @required this.player}) : super(key: key);

  @override
  _EditPlayerScreenState createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {
  EditPlayerBloc _editPlayerBloc;

  @override
  void initState() {
    super.initState();
    _editPlayerBloc = getItInstance<EditPlayerBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _editPlayerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.createPlayer),
      ),
      body: BlocListener(
        cubit: _editPlayerBloc,
        listener: (context, EditPlayerState state) {
          // hide previous snackbars
          Scaffold.of(context).hideCurrentSnackBar();

          // if fail when login show snackbar fail
          if (state.status == EditPlayerStatus.error) {
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
          if (state.status == EditPlayerStatus.edited) {
            Navigator.of(context).pop();
          }
        },
        child: BlocProvider(
          create: (_) => _editPlayerBloc,
          child: EditPlayerForm(
            playerEntity: widget.player,
          ),
        ),
      ),
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
