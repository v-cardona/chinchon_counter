import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {
  final int id;
  final String name;
  final int color;

  PlayerEntity({this.id, this.name, this.color});

  @override
  List<Object> get props => [name, color];
}
