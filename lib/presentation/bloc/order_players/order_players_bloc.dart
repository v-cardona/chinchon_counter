import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chinchon_counter/domain/entities/player_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_players_event.dart';
part 'order_players_state.dart';

class OrderPlayersBloc extends Bloc<OrderPlayersEvent, OrderPlayersState> {
  OrderPlayersBloc() : super(OrderPlayersState());

  @override
  Stream<OrderPlayersState> mapEventToState(
    OrderPlayersEvent event,
  ) async* {
    if (event is InitOrderPlayerEvent) {
      yield state.copyWith(players: event.players);
    } else if (event is MovePlayerOrderEvent) {
      List<PlayerEntity> oldList = event.players;
      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      PlayerEntity oldPlayer = oldList.removeAt(oldIndex);
      oldList.insert(newIndex, oldPlayer);
      oldList.forEach((element) {
        print(element.name);
      });
      yield state.copyWith(players: oldList, nUpdates: state.nUpdates + 1);
    }
  }
}
