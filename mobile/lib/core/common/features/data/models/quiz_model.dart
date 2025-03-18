import 'package:hive_ce/hive.dart';

import 'dart:convert';

import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/common/features/domain/entities/quiz_entity.dart';


part 'quiz_model.g.dart';

List<QuizModel> quizModelFromJson(String str) =>
    List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 3)
class QuizModel extends QuizEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final bool isTested;

  @HiveField(2)
  final int correctCount;

  @HiveField(3)
  final int incorrectCount;

  @HiveField(4)
  final int didNotAnswerCount;

  @HiveField(5)
  final int status;

  @HiveField(6)
  final String type;

  @HiveField(7)
  final String name;

  @HiveField(8)
  final int time_to_do;

  @HiveField(9)
  final int time_used;

  @HiveField(10)
  final List<QuestionModel> questions;

  const QuizModel({
    required this.id,
    required this.isTested,
    required this.correctCount,
    required this.incorrectCount,
    this.didNotAnswerCount = 0,
    required this.status,
    required this.type,
    required this.name,
    required this.time_to_do,
    required this.time_used,
    this.questions = const [],
  }) : super(
            id: 0,
            isTested: false,
            correctCount: 0,
            incorrectCount: 0,
            didNotAnswerCount: 0,
            status: 0,
            type: '',
            name: '',
            time_to_do: 0,
            time_used: 0);

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
      isTested: json['isTested'] as bool? ?? false,
      correctCount: json['correctCount'] as int? ?? 0,
      incorrectCount: json['incorrectCount'] as int? ?? 0,
      didNotAnswerCount: json['didNotAnswerCount'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      type: json['type'] as String,
      name: json['name'] as String,
      time_to_do: json['time_to_do'] as int? ?? 0,
      time_used: json['time_used'] as int? ?? 0,
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
