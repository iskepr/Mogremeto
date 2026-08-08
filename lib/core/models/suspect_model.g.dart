// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suspect_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuspectAdapter extends TypeAdapter<Suspect> {
  @override
  final int typeId = 4;

  @override
  Suspect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Suspect(
      name: fields[0] as String,
      role: fields[1] as String,
      image: fields[2] as String,
      description: fields[3] as String,
      isCulprit: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Suspect obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.isCulprit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuspectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
