part of 'player_bloc.dart';

class PlayerState extends Equatable {

  final List<PlayerEntity> playersEntity;
  final PlayerEntity playerEntity;
  final String name;
  final int color;
  final AppError appEror;
  final PlayerStatus status;

  const PlayerState({this.playersEntity, this.playerEntity, this.name = '', this.color, this.appEror, this.status = PlayerStatus.initial});
  
  @override
  List<Object> get props => [playersEntity, playerEntity, name, color, appEror, status];

  
  PlayerState copyWith({
  List<PlayerEntity> playersEntity,
  PlayerEntity playerEntity,
  String name,
  int color,
  AppError appEror,
  PlayerStatus status
  }) {
    return PlayerState(
      playersEntity: playersEntity ?? this.playersEntity,
      playerEntity: playerEntity ?? this.playerEntity,
      name: name ?? this.name,
      color: color ?? this.color,
      appEror: appEror ?? this.appEror,
      status: status ?? this.status,
    );
  }
}

enum PlayerStatus { initial, loading, playerLoaded, playersLoaded, created, edited, deleted, error}
