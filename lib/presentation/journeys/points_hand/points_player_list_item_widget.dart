import 'package:chinchon_counter/common/constants/game_constants.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/bloc/game/game_bloc.dart';
import 'package:chinchon_counter/presentation/bloc/points_hand/points_hand_bloc.dart';
import 'package:chinchon_counter/presentation/journeys/points_hand/points_number_field.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsPlayerListItem extends StatelessWidget {
  final PlayerEntity player;
  final int index;

  const PointsPlayerListItem(
      {@required this.player, Key key, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameState gameState = BlocProvider.of<GameBloc>(context).state;

    if (gameState.lifes[index] != GameConstants.dead_player) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              leading: UserColorWidget(
                color: player.color,
              ),
              title: PointsNumberField(
                labelText: player.name,
                onPressed: (value) => BlocProvider.of<PointsHandBloc>(context)
                    .add(ChangePointsEvent(
                        indexPlayer: index, points: int.parse(value))),
              )),
          Divider(
            color: Colors.white,
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
