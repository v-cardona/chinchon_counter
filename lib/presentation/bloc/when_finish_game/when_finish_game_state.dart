part of 'when_finish_game_bloc.dart';

abstract class WhenFinishGameState extends Equatable {
  const WhenFinishGameState();

  @override
  List<Object> get props => [];
}

class WhenFinishGameInitial extends WhenFinishGameState {}

class WhenFinishGameChanged extends WhenFinishGameState {
  final WhenFinishGameOptions whenFinish;

  WhenFinishGameChanged({@required this.whenFinish});

  @override
  List<Object> get props => [whenFinish];
}

enum WhenFinishGameOptions { firstDead, lastDead }
