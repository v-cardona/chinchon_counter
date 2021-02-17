import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/player/player_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/edit_player/edit_player_screen.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPlayersListItem extends StatelessWidget {
  final PlayerEntity player;

  const AllPlayersListItem({@required this.player, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => EditPlayerScreen(
              player: player,
            ),
          ))
              .then((value) {
            print(value);
            BlocProvider.of<PlayerBloc>(context).add(GetAllPlayersEvent());
            if (value == 'deleted') {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(TranslationConstants.deletedPlayer.translate()),
                    Icon(Icons.info)
                  ],
                ),
                backgroundColor: Colors.deepPurple,
              ));
            }
          }),
          leading: UserColorWidget(
            color: player.color,
          ),
          title: Text(
            player.name,
            style: TextStyle(color: Colors.white, fontSize: Sizes.dimen_18.sp),
          ),
        ),
        Divider(
          color: Colors.white,
        )
      ],
    );
  }
}
