import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/entities/answer_entity.dart';
import 'question_model.dart';

class AnswerModel extends AnswerEntity {


  const AnswerModel({
    required super.id,
    required super.text,
    required super.isCorrect,
    required super.question,
  });

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
      question: QuestionModel.fromJson(json['question'] as Map<String, dynamic>),
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
