part of 'create_player_bloc.dart';

class CreatePlayerState extends Equatable {

  final String name;
  final int color;
  final AppError appEror;
  final CreatePlayerStatus status;

  const CreatePlayerState({this.name = '', this.color, this.appEror, this.status = CreatePlayerStatus.initial});
  
  @override
  List<Object> get props => [name, color, appEror, status];

  
  CreatePlayerState copyWith({
  String name,
  int color,
  AppError appEror,
  CreatePlayerStatus status
  }) {
    return CreatePlayerState(
      name: name ?? this.name,
      color: color ?? this.color,
      appEror: appEror ?? this.appEror,
      status: status ?? this.status,
    );
  }
}

enum CreatePlayerStatus { initial, loading, created, error}
