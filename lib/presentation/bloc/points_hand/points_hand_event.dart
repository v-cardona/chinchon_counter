part of 'points_hand_bloc.dart';

abstract class PointsHandEvent extends Equatable {
  const PointsHandEvent();

  @override
  List<Object> get props => [];
}

class ChangePointsEvent extends PointsHandEvent {
  final int points;
  final int indexPlayer;

  ChangePointsEvent({@required this.points, @required this.indexPlayer});

  @override
  List<Object> get props => [points, indexPlayer];
}

class SavePointsEvent extends PointsHandEvent {}

class InitPointsHandEvent extends PointsHandEvent {
  final List<PlayerEntity> players;

  InitPointsHandEvent({@required this.players});

  @override
  List<Object> get props => [players];
}

class AddPointsHandEvent extends PointsHandEvent {}
