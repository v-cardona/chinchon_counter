part of 'select_lifes_game_bloc.dart';

abstract class SelectLifesGameEvent extends Equatable {
  const SelectLifesGameEvent();

  @override
  List<Object> get props => [];
}

class ToggleSelecLifeEvent extends SelectLifesGameEvent {
  final int lifes;

  ToggleSelecLifeEvent({@required this.lifes});

  @override
  List<Object> get props => [lifes];
}
