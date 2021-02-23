part of 'points_hand_bloc.dart';

class PointsHandState extends Equatable {
  final List<int> points;
  final PointsHandStatus status;

  const PointsHandState({this.status, this.points});

  @override
  List<Object> get props => [points, status];

  PointsHandState copyWith({List<int> points, PointsHandStatus status}) {
    return PointsHandState(
      points: points ?? this.points,
      status: status ?? this.status,
    );
  }
}

enum PointsHandStatus { initial, changed, submitted }
