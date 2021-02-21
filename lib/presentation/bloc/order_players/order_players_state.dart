part of 'order_players_bloc.dart';

class OrderPlayersState extends Equatable {
  final List<PlayerEntity> players;
  final int nUpdates; // necesario para indicar el cambio de estado

  OrderPlayersState({this.players = const [], this.nUpdates = 0});

  @override
  List<Object> get props => [players, nUpdates];

  OrderPlayersState copyWith({List<PlayerEntity> players, int nUpdates}) {
    return OrderPlayersState(
        players: players ?? this.players, nUpdates: nUpdates ?? this.nUpdates);
  }
}
