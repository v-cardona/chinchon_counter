import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';

class AllPlayersListItem extends StatelessWidget {
  final PlayerEntity player;

  const AllPlayersListItem({@required this.player, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: UserColorWidget(color: player.color,),
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
