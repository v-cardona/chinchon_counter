part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class InitialState extends PlayerState {}

class LoadingPlayerState extends PlayerState {}

class LoadedAllPlayers extends PlayerState {
  final List<PlayerEntity> playersList;

  LoadedAllPlayers({@required this.playersList});
  
  @override
  List<Object> get props => [playersList];
}

class ErrorPlayerState extends PlayerState {
  
  final AppError error;

  ErrorPlayerState({@required this.error});
  
  @override
  List<Object> get props => [error];
}