import 'package:equatable/equatable.dart';
import 'question_model.dart';

class AnswerModel extends Equatable {
  final int id;
  final String text;
  final bool isCorrect;
  final QuestionModel question;

  const AnswerModel({
    required this.id,
    required this.text,
    required this.isCorrect,
    required this.question,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      id: json['id'] as int,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
      question: QuestionModel.fromJson(json['question']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
      'question': question.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, text, isCorrect, question];
}
