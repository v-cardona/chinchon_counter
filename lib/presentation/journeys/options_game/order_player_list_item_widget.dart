import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/constants/translation_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/common/extensions/string_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/widgets/user_color_widget.dart';
import 'package:flutter/material.dart';

class OrderPlayerListItem extends StatelessWidget {
  final PlayerEntity player;

  const OrderPlayerListItem({@required this.player, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      key: key,
      children: [
        ListTile(
          leading: UserColorWidget(
            color: player.color,
          ),
          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(TranslationConstants.longPressOrderPlayers.translate()),
                Icon(Icons.info)
              ],
            ),
            backgroundColor: Colors.deepPurple,
          )),
          trailing: Icon(
            Icons.menu,
            color: Colors.white,
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
