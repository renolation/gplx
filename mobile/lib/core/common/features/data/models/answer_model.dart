import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/entities/answer_entity.dart';
import 'question_model.dart';
import 'package:hive_ce/hive.dart';

part 'answer_model.g.dart';

@HiveType(typeId: 1)
class AnswerModel extends AnswerEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final bool isCorrect;

  @HiveField(3)
  final QuestionModel? question;

  const AnswerModel({
    required this.id,
    required this.text,
    required this.isCorrect,
    required this.question,
  }) : super(
          id: id,
          text: text,
          isCorrect: isCorrect,
          question: question,
        );

  AnswerModel copyWith({
    int? id,
    String? text,
    bool? isCorrect,
    QuestionModel? question,
  }) {
    return AnswerModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      question: question ?? this.question,
    );
  }

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] as int,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
      question: json['question'] == null ? null : QuestionModel.fromJson(json['question'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
      'question': (question as QuestionModel).toJson(),
    };
  }

  @override
  List<Object?> get props => [id, text, isCorrect, question];
}
