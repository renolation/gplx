
import 'dart:convert';

import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/common/features/domain/entities/quiz_entity.dart';


List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class QuizModel extends QuizEntity {

  const QuizModel({
    required super.id,
    required super.isTested,
    required super.correctCount,
    required super.incorrectCount,
     super.didNotAnswerCount = 0,
    required super.status,
    required super.type,
    required super.name,
    required super.time_to_do,
    required super.time_used,
    super.questions = const [],
});

  QuizModel copyWith({
    int? id,
    bool? isTested,
    int? correctCount,
    int? incorrectCount,
    int? didNotAnswerCount,
    int? status,
    String? type,
    String? name,
    int? time_to_do,
    int? time_used,
    List<QuestionModel>? questions,
  }) {
    return QuizModel(
      id: id ?? this.id,
      isTested: isTested ?? this.isTested,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      didNotAnswerCount: didNotAnswerCount ?? this.didNotAnswerCount,
      status: status ?? this.status,
      type: type ?? this.type,
      name: name ?? this.name,
      time_to_do: time_to_do ?? this.time_to_do,
      time_used: time_used ?? this.time_used,
      questions: questions ?? this.questions,
    );
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] as int,
      isTested: json['isTested'] as bool,
      correctCount: json['correctCount'] as int,
      incorrectCount: json['incorrectCount'] as int,
      didNotAnswerCount: json['didNotAnswerCount'] as int,
      status: json['status'] as int,
      type: json['type'] as String,
      name: json['name'] as String,
      time_to_do: json['time_to_do'] as int,
      time_used: json['time_used'] as int,
      questions: (json['question'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isTested': isTested,
      'correctCount': correctCount,
      'incorrectCount': incorrectCount,
      'didNotAnswerCount': didNotAnswerCount,
      'status': status,
      'type': type,
      'name': name,
      'time_to_do': time_to_do,
      'time_used': time_used,
      'questions': questions.map((e) => (e as QuestionModel).toJson()).toList(),
    };
  }
}