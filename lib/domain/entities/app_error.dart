import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType errorType;

  AppError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

enum AppErrorType {
  dba,
  errorMsgGeneral,
  colorNotAvailable,
  nameEmpty,
  minPlayers,
  maxPlayers
}
