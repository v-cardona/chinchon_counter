part of 'select_players_bloc.dart';

class SelectPlayersState extends Equatable {
  final List<PlayerCheckEntity> players;
  final List<PlayerCheckEntity> selectedPlayers;
  final AppError appError;
  final SelectPlayerStatus status;

  const SelectPlayersState({this.selectedPlayers, this.players, this.appError, this.status = SelectPlayerStatus.initial});

  @override
  List<Object> get props => [players, appError, status];

  SelectPlayersState copyWith(
      {List<PlayerCheckEntity> players,
      List<PlayerCheckEntity> selectedPlayers,
      AppError appError,
      SelectPlayerStatus status}) {
    return SelectPlayersState(
      players: players ?? this.players,
      selectedPlayers: selectedPlayers ?? this.selectedPlayers,
      appError: appError ?? this.appError,
      status: status ?? this.status,
    );
  }
}

enum SelectPlayerStatus { initial, loading, loaded, selectedPlayers, error }
