part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
  
  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerLoading extends PlayerState {}

class PlayerError extends PlayerState {
  final AppError appError;

  PlayerError(this.appError);

  @override
  List<Object> get props => [appError];}

class PlayerLoaded extends PlayerState {
  final PlayerEntity playerEntity;

  PlayerLoaded(this.playerEntity);

  @override
  List<Object> get props => [playerEntity];
}

class AllPlayerLoaded extends PlayerState {
  final List<PlayerEntity> playersEntity;

  AllPlayerLoaded(this.playersEntity);

  @override
  List<Object> get props => [playersEntity];
}

class LoadPlayers extends PlayerState {}