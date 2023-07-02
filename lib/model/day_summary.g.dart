// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_summary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DSummaryAdapter extends TypeAdapter<DSummary> {
  @override
  final int typeId = 3;

  @override
  DSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DSummary(
      text: fields[0] as String,
      day: fields[1] as int,
      month: fields[2] as int,
      id: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DSummary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DSummaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
