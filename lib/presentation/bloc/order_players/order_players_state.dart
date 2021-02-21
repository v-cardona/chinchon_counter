part of 'order_players_bloc.dart';

class OrderPlayersState extends Equatable {
  final List<PlayerEntity> players;
  final int nUpdates; // necesario para indicar el cambio de estado
  final OrderPlayerStatus status;
  final AppError appError;

  OrderPlayersState(
      {this.appError,
      this.status = OrderPlayerStatus.initial,
      this.players = const [],
      this.nUpdates = 0});

  @override
  List<Object> get props => [players, nUpdates];

  OrderPlayersState copyWith(
      {List<PlayerEntity> players,
      int nUpdates,
      OrderPlayerStatus status,
      AppError appError}) {
    return OrderPlayersState(
        players: players ?? this.players,
        nUpdates: nUpdates ?? this.nUpdates,
        status: status ?? this.status,
        appError: appError ?? this.appError);
  }
}

enum OrderPlayerStatus { initial, loaded, error }
