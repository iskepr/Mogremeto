// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evidence_document.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EvidenceDocumentAdapter extends TypeAdapter<EvidenceDocument> {
  @override
  final int typeId = 5;

  @override
  EvidenceDocument read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EvidenceDocument(
      title: fields[0] as String,
      type: fields[1] as String?,
      image: fields[2] as String?,
      content: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EvidenceDocument obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EvidenceDocumentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
