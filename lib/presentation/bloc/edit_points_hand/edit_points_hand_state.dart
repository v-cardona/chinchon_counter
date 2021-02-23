part of 'edit_points_hand_bloc.dart';

class EditPointsHandState extends Equatable {
  final int points;
  final EditPointsHandStatus status;

  const EditPointsHandState(
      {this.points, this.status = EditPointsHandStatus.initial});

  @override
  List<Object> get props => [points, status];

  EditPointsHandState copyWith({int points, EditPointsHandStatus status}) {
    return EditPointsHandState(
      points: points ?? this.points,
      status: status ?? this.status,
    );
  }
}

enum EditPointsHandStatus { initial, changed, submitted }
