part of 'edit_player_bloc.dart';

class EditPlayerState extends Equatable {

  final String name;
  final int color;
  final AppError appEror;
  final EditPlayerStatus status;

  const EditPlayerState({this.name = '', this.color, this.appEror, this.status = EditPlayerStatus.initial});
  
  @override
  List<Object> get props => [name, color, appEror, status];

  
  EditPlayerState copyWith({
  String name,
  int color,
  AppError appEror,
  EditPlayerStatus status
  }) {
    return EditPlayerState(
      name: name ?? this.name,
      color: color ?? this.color,
      appEror: appEror ?? this.appEror,
      status: status ?? this.status,
    );
  }
}

enum EditPlayerStatus { initial, loading, edited, deleted, error}
