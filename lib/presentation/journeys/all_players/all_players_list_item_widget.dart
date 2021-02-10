import 'package:chinchon_counter/common/constants/size_constants.dart';
import 'package:chinchon_counter/common/extensions/size_extensions.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';

class AllPlayersListItem extends StatelessWidget {

  final PlayerEntity player;

  const AllPlayersListItem({@required this.player, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Container(
              margin: EdgeInsets.all(Sizes.dimen_10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Sizes.dimen_10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(player.color),
                    ),
                    width: Sizes.dimen_32,
                    height: Sizes.dimen_32,
                  ),
                  Text(
                    player.name,
                    style: TextStyle(
                        color: Colors.white, fontSize: Sizes.dimen_18.sp),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            )
          ],
        );
  }
}