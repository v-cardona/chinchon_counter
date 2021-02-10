import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:chinchon_counter/presentation/journeys/all_players/all_players_list_item_widget.dart';
import 'package:flutter/material.dart';

class AllPlayersList extends StatelessWidget {
  final List<PlayerEntity> playersList;

  const AllPlayersList({Key key, @required this.playersList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playersList.length,
      itemBuilder: (BuildContext context, int index) {
        PlayerEntity player = playersList[index];
        return AllPlayersListItem(player: player);
      },
    );
  }
}
