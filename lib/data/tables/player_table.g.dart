// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerTableAdapter extends TypeAdapter<PlayerTable> {
  @override
  final int typeId = 0;

  @override
  PlayerTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerTable(
      id: fields[0] as int,
      name: fields[1] as String,
      color: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlayerTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
