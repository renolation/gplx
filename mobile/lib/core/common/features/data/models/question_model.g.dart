// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionModelAdapter extends TypeAdapter<QuestionModel> {
  @override
  final int typeId = 0;

  @override
  QuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModel(
      id: (fields[0] as num).toInt(),
      index: (fields[1] as num).toInt(),
      text: fields[2] as String,
      image: fields[3] as String?,
      explain: fields[4] as String,
      type: fields[5] as String?,
      isImportant: fields[6] == null ? false : fields[6] as bool,
      vehicle: fields[7] as String,
      chapter: fields[8] as ChapterModel?,
      answers: fields[9] == null
          ? const []
          : (fields[9] as List).cast<AnswerModel>(),
      status: fields[10] == null ? 0 : (fields[10] as num).toInt(),
      isCorrect: fields[11] == null ? false : fields[11] as bool,
      selectedAnswer: fields[12] as AnswerModel?,
      chapterId: (fields[13] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.explain)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.isImportant)
      ..writeByte(7)
      ..write(obj.vehicle)
      ..writeByte(8)
      ..write(obj.chapter)
      ..writeByte(9)
      ..write(obj.answers)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.isCorrect)
      ..writeByte(12)
      ..write(obj.selectedAnswer)
      ..writeByte(13)
      ..write(obj.chapterId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
