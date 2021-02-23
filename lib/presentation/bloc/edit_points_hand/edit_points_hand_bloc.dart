import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'edit_points_hand_event.dart';
part 'edit_points_hand_state.dart';

class EditPointsHandBloc
    extends Bloc<EditPointsHandEvent, EditPointsHandState> {
  EditPointsHandBloc() : super(EditPointsHandState());

  @override
  Stream<EditPointsHandState> mapEventToState(
    EditPointsHandEvent event,
  ) async* {
    if (event is ChangeEditPointHandEvent) {
      yield state.copyWith(
          points: event.points, status: EditPointsHandStatus.changed);
    } else if (event is SaveEditPointHandEvent) {
      yield state.copyWith(status: EditPointsHandStatus.submitted);
    }
  }
}
