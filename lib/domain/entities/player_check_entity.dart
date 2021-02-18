import 'package:chinchon_counter/domain/entities/player_entity.dart';

class PlayerCheckEntity extends PlayerEntity {
  final int id;
  final String name;
  final int color;
  bool selected;

  PlayerCheckEntity({this.id, this.name, this.color, this.selected})
      : super(id: id, name: name, color: color);

      
  factory PlayerCheckEntity.fromPlayerEntity(PlayerEntity playerEntity) {
    return PlayerCheckEntity(
      id: playerEntity.id,
      color: playerEntity.color,
      name: playerEntity.name,
      selected: false
    );
  }
}
