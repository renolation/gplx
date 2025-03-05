// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizModelAdapter extends TypeAdapter<QuizModel> {
  @override
  final int typeId = 3;

  @override
  QuizModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizModel(
      id: (fields[0] as num).toInt(),
      isTested: fields[1] as bool,
      correctCount: (fields[2] as num).toInt(),
      incorrectCount: (fields[3] as num).toInt(),
      didNotAnswerCount: fields[4] == null ? 0 : (fields[4] as num).toInt(),
      status: (fields[5] as num).toInt(),
      type: fields[6] as String,
      name: fields[7] as String,
      time_to_do: (fields[8] as num).toInt(),
      time_used: (fields[9] as num).toInt(),
      questions: fields[10] == null
          ? const []
          : (fields[10] as List).cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuizModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isTested)
      ..writeByte(2)
      ..write(obj.correctCount)
      ..writeByte(3)
      ..write(obj.incorrectCount)
      ..writeByte(4)
      ..write(obj.didNotAnswerCount)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.time_to_do)
      ..writeByte(9)
      ..write(obj.time_used)
      ..writeByte(10)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
