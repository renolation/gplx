import 'package:equatable/equatable.dart';
import '../../domain/entities/question_entity.dart';
import 'chapter_model.dart';
import 'answer_model.dart';

import 'dart:convert';

List<QuestionModel> questionModelFromJson(String str) =>
    List<QuestionModel>.from(json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionModelToJson(List<QuestionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.index,
    required super.text,
    super.image,
    required super.explain,
    super.type,
    super.isImportant = false,
    required super.vehicle,
    super.chapter,
    super.answers = const [],
    this.status = 0,
    this.isCorrect = false,
    this.selectedAnswer,
    this.chapterId,
  });

  //note: 0: not answered, 1: answered and correct, 2: answered and incorrect
  final int status;
  final bool isCorrect;
  final AnswerModel? selectedAnswer;
  final int? chapterId;

  QuestionModel copyWith({
    int? id,
    int? index,
    String? text,
    String? image,
    String? explain,
    String? type,
    bool? isImportant,
    String? vehicle,
    ChapterModel? chapter,
    List<AnswerModel>? answers,
    int? status,
    bool? isCorrect,
    AnswerModel? selectedAnswer,
    int? chapterId,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      index: index ?? this.index,
      text: text ?? this.text,
      image: image ?? this.image,
      explain: explain ?? this.explain,
      type: type ?? this.type,
      isImportant: isImportant ?? this.isImportant,
      vehicle: vehicle ?? this.vehicle,
      chapter: chapter ?? this.chapter as ChapterModel,
      answers: answers ?? this.answers as List<AnswerModel>,
      status: status ?? this.status,
      isCorrect: isCorrect ?? this.isCorrect,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      chapterId: chapterId ?? this.chapterId,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, isCorrect, selectedAnswer];

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as int,
      index: json['index'] as int,
      text: json['text'] as String,
      image: json['image'] as String?,
      explain: json['explain'] as String,
      type: json['type'] as String?,
      isImportant: json['isImportant'] as bool? ?? false,
      vehicle: json['vehicle'] as String,
      chapter: json['chapter'] == null ? null : ChapterModel.fromJson(json['chapter'] as Map<String, dynamic>),
      answers:
          (json['answer'] as List<dynamic>?)?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>)).toList() ??
              [],
      chapterId: json['chapterId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'text': text,
      'image': image,
      'explain': explain,
      'type': type,
      'isImportant': isImportant,
      'vehicle': vehicle,
      'chapter': (chapter as ChapterModel).toJson(),
      'answers': answers?.map((e) => (e as AnswerModel).toJson()).toList(),
    };
  }
}
