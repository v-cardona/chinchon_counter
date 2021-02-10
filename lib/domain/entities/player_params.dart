import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:equatable/equatable.dart';

class PlayerParams extends Equatable {
  final int playerId;
  final PlayerEntity playerEntity;

  PlayerParams({this.playerId, this.playerEntity});
  
  @override
  List<Object> get props => [];
}
