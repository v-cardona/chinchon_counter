part of 'edit_points_hand_bloc.dart';

abstract class EditPointsHandEvent extends Equatable {
  const EditPointsHandEvent();

  @override
  List<Object> get props => [];
}

class ChangeEditPointHandEvent extends EditPointsHandEvent {
  final int points;

  ChangeEditPointHandEvent({@required this.points});

  @override
  List<Object> get props => [points];
}

class SaveEditPointHandEvent extends EditPointsHandEvent {}
