// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'victim_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VictimAdapter extends TypeAdapter<Victim> {
  @override
  final int typeId = 1;

  @override
  Victim read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Victim(
      name: fields[0] as String,
      role: fields[1] as String,
      image: fields[2] as String,
      details: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Victim obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VictimAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
