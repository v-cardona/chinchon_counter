import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_check_entity.dart';
import 'package:chinchon_counter/presentation/bloc/select_players/select_players_bloc.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckablePlayerListItem extends StatelessWidget {
  final PlayerCheckEntity player;

  const CheckablePlayerListItem({@required this.player, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          checkColor: Colors.black,
          onChanged: (value) => BlocProvider.of<SelectPlayersBloc>(context)
              .add(ToggleSelectPlayerEvent(playerId: player.id, value: value)),
          value: player.selected,
          secondary: UserColorWidget(
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
