import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {
  final String name;
  final int color;

  PlayerEntity({this.name, this.color});

  @override
  List<Object> get props => [name, color];
}
