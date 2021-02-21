part of 'select_lifes_game_bloc.dart';

abstract class SelectLifesGameState extends Equatable {
  const SelectLifesGameState();

  @override
  List<Object> get props => [];
}

class SelectLifesGameInitial extends SelectLifesGameState {}

class ChangedSelectLifesGameState extends SelectLifesGameState {
  final int lifes;

  ChangedSelectLifesGameState({@required this.lifes});

  @override
  List<Object> get props => [lifes];
}
