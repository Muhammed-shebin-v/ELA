// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SleepModelAdapter extends TypeAdapter<SleepModel> {
  @override
  final int typeId = 9;

  @override
  SleepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SleepModel(
      date: fields[0] as DateTime,
      intake: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SleepModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.intake);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
