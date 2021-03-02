part of 'when_finish_game_bloc.dart';

abstract class WhenFinishGameEvent extends Equatable {
  const WhenFinishGameEvent();

  @override
  List<Object> get props => [];
}

class ToogleWhenFinishEvent extends WhenFinishGameEvent {
  final WhenFinishGameOptions whenFinish;

  ToogleWhenFinishEvent({@required this.whenFinish});

  @override
  List<Object> get props => [whenFinish];
}
