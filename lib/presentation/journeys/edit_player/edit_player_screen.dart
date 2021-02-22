import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/app_error_extension.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/di/get_it.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/edit_player/edit_player_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/alert_dialog_widget.dart';
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
        title: Text(TranslationConstants.editPlayer.translate()),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red[200],
              ),
              onPressed: () => showDialog(
                  context: context,
                  child: AlertDialogWidget(
                      title: TranslationConstants.areYouSure.translate(),
                      content:
                          TranslationConstants.reallyDeletePlayer.translate(),
                      onPressedYes: () {
                        _editPlayerBloc
                            .add(DeletePlayerEvent(playerId: widget.player.id));
                        Navigator.of(context).pop();
                      })))
        ],
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
                children: [Text(state.appEror.showError()), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
          } else if (state.status == EditPlayerStatus.edited) {
            // if login success emit Logged state to change to allPlayers
            Navigator.of(context).pop();
          } else if (state.status == EditPlayerStatus.deleted) {
            // if login success emit Logged state to change to allPlayers
            Navigator.of(context).pop('deleted');
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
}
