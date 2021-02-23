import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'points_hand_event.dart';
part 'points_hand_state.dart';

class PointsHandBloc extends Bloc<PointsHandEvent, PointsHandState> {
  PointsHandBloc() : super(PointsHandState());

  @override
  Stream<PointsHandState> mapEventToState(
    PointsHandEvent event,
  ) async* {
    if (event is InitPointsHandEvent) {
      List<int> points = List.filled(event.players.length, 0);
      yield state.copyWith(points: points, status: PointsHandStatus.changed);
    } else if (event is ChangePointsEvent) {
      List<int> points = state.points;
      points[event.indexPlayer] = event.points;
      yield state.copyWith(points: points, status: PointsHandStatus.changed);
    } else if (event is AddPointsHandEvent) {
      List<int> points = state.points;
      yield state.copyWith(points: points, status: PointsHandStatus.submitted);
    }
  }
}
