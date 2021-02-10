import 'package:chinchon_counter/common/constants/db_local_constats.dart';
import 'package:chinchon_counter/data/tables/player_table.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class PlayersLocalDataSource {
  Future<List<PlayerTable>> getPlayers();
  Future<PlayerTable> getPlayer(int playerId);
  Future<void> createPlayer(PlayerTable playerTable);
  Future<void> deletePlayer(int playerId);
  Future<void> editPlayer(PlayerTable playerTable);
  Future<bool> checkIfColorIsAvailable(Color color);
}

class PlayersLocalDataSourceImpl extends PlayersLocalDataSource {
  @override
  Future<List<PlayerTable>> getPlayers() async {
    final playersBox = await Hive.openBox(DbLocalConstants.playersBox);
    final playersIds = playersBox.keys;
    List<PlayerTable> players = [];
    playersIds.forEach((playerId) {
      players.add(playersBox.get(playerId));
    });
    return players;
  }
  
  @override
  Future<PlayerTable> getPlayer(int playerId) async {
    final playersBox = await Hive.openBox(DbLocalConstants.playersBox);
    return playersBox.getAt(playerId);
  }

  @override
  Future<bool> checkIfColorIsAvailable(Color color) {
    // TODO: implement checkIfColorIsAvailable
    throw UnimplementedError();
  }

  @override
  Future<void> createPlayer(PlayerTable playerTable) async {
    final playerBox = await Hive.openBox(DbLocalConstants.playersBox);
    await playerBox.put(playerTable.id, playerTable);
  }

  @override
  Future<void> deletePlayer(int playerId) async {
    final playerBox = await Hive.openBox(DbLocalConstants.playersBox);
    await playerBox.delete(playerId);
  }

  @override
  Future<void> editPlayer(PlayerTable playerTable) async {
    final playerBox = await Hive.openBox(DbLocalConstants.playersBox);
    await playerBox.putAt(playerTable.id, playerTable);
  }
}
