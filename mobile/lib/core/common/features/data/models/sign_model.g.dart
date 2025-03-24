// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignModelAdapter extends TypeAdapter<SignModel> {
  @override
  final int typeId = 4;

  @override
  SignModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      desc: fields[2] as String,
      image: fields[3] as String,
      bold: fields[4] as String,
      type: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.desc)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.bold)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
