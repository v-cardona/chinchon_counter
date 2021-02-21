part of 'order_players_bloc.dart';

abstract class OrderPlayersEvent extends Equatable {
  const OrderPlayersEvent();

  @override
  List<Object> get props => [];
}

class InitOrderPlayerEvent extends OrderPlayersEvent {
  final List<PlayerEntity> players;

  const InitOrderPlayerEvent({@required this.players});

  @override
  List<Object> get props => [players];
}

class MovePlayerOrderEvent extends OrderPlayersEvent {
  final int oldIndex;
  final int newIndex;
  final List<PlayerEntity> players;

  MovePlayerOrderEvent(
      {@required this.players,
      @required this.oldIndex,
      @required this.newIndex});

  @override
  List<Object> get props => [players, oldIndex, newIndex];
}

class DeletedPlayerEvent extends OrderPlayersEvent {
  final PlayerEntity player;

  DeletedPlayerEvent({@required this.player});

  @override
  List<Object> get props => [player];
}
