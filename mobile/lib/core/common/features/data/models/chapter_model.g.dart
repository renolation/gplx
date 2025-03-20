// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterModelAdapter extends TypeAdapter<ChapterModel> {
  @override
  final int typeId = 2;

  @override
  ChapterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChapterModel(
      id: (fields[0] as num).toInt(),
      index: (fields[1] as num).toInt(),
      name: fields[2] as String,
      questions: fields[3] == null
          ? const []
          : (fields[3] as List).cast<QuestionModel>(),
      isImportant: fields[4] == null ? false : fields[4] as bool,
      vehicle: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChapterModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.questions)
      ..writeByte(4)
      ..write(obj.isImportant)
      ..writeByte(5)
      ..write(obj.vehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
