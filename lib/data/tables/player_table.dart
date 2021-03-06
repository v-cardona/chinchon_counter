import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player_table.g.dart';

@HiveType(typeId: 0)
class PlayerTable extends PlayerEntity {

  @HiveField(0)
  int id;

  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final int color;

  PlayerTable({this.id, @required this.name, @required this.color}) : super(id: id, name: name, color: color);

  factory PlayerTable.fromPlayerEntity(PlayerEntity playerEntity) {
    return PlayerTable(
      id: playerEntity.id,
      color: playerEntity.color,
      name: playerEntity.name
    );
  }

}