// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaseModelAdapter extends TypeAdapter<CaseModel> {
  @override
  final int typeId = 0;

  @override
  CaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaseModel(
      id: fields[0] as String,
      title: fields[1] as String,
      type: fields[2] as String,
      gameMode: fields[3] as GameMode,
      difficulty: fields[4] as String,
      victim: fields[5] as Victim?,
      location: fields[6] as Location?,
      timeOfCrime: fields[7] as String,
      weapon: fields[8] as Weapon?,
      suspects: (fields[9] as List).cast<Suspect>(),
      evidenceDocuments: (fields[10] as List).cast<EvidenceDocument>(),
      story: fields[11] as String,
      culpritExplanation: fields[12] as String,
      real: fields[13] as bool,
      source: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CaseModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.gameMode)
      ..writeByte(4)
      ..write(obj.difficulty)
      ..writeByte(5)
      ..write(obj.victim)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.timeOfCrime)
      ..writeByte(8)
      ..write(obj.weapon)
      ..writeByte(9)
      ..write(obj.suspects)
      ..writeByte(10)
      ..write(obj.evidenceDocuments)
      ..writeByte(11)
      ..write(obj.story)
      ..writeByte(12)
      ..write(obj.culpritExplanation)
      ..writeByte(13)
      ..write(obj.real)
      ..writeByte(14)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GameModeAdapter extends TypeAdapter<GameMode> {
  @override
  final int typeId = 6;

  @override
  GameMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GameMode.roleplay;
      case 1:
        return GameMode.detective;
      default:
        return GameMode.roleplay;
    }
  }

  @override
  void write(BinaryWriter writer, GameMode obj) {
    switch (obj) {
      case GameMode.roleplay:
        writer.writeByte(0);
        break;
      case GameMode.detective:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameModeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
