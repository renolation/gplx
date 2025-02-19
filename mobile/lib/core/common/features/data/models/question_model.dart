import 'package:hive_ce/hive.dart';
import '../../domain/entities/question_entity.dart';
import 'chapter_model.dart';
import 'answer_model.dart';

import 'dart:convert';

part 'question_model.g.dart';

List<QuestionModel> questionModelFromJson(String str) =>
    List<QuestionModel>.from(
        json.decode(str).map((x) => QuestionModel.fromJson(x)));

String questionModelToJson(List<QuestionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class QuestionModel extends QuestionEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int index;

  @HiveField(2)
  final String text;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String explain;

  @HiveField(5)
  final String? type;

  @HiveField(6)
  final bool isImportant;

  @HiveField(7)
  final String vehicle;

  @HiveField(8)
  final ChapterModel? chapter;

  @HiveField(9)
  final List<AnswerModel> answers;

  //note: 0: not answered, 1: answered and correct, 2: answered and incorrect
  @HiveField(10)
  final int status;

  @HiveField(11)
  final bool isCorrect;

  @HiveField(12)
  final AnswerModel? selectedAnswer;

  @HiveField(13)
  final int? chapterId;

  const QuestionModel({
    required this.id,
    required this.index,
    required this.text,
    this.image,
    required this.explain,
    this.type,
    this.isImportant = false,
    required this.vehicle,
    this.chapter,
    this.answers = const [],
    this.status = 0,
    this.isCorrect = false,
    this.selectedAnswer,
    this.chapterId,
  }) : super(
          id: id,
          index: index,
          text: text,
          image: image,
          explain: explain,
          type: type,
          isImportant: isImportant,
          vehicle: vehicle,
          chapter: chapter,
          answers: answers,
        );

  factory QuestionModel.empty() => const QuestionModel(
        id: 0,
        index: 0,
        text: '',
        image: '',
        explain: '',
        type: '',
        isImportant: false,
        vehicle: '',
        answers: [],
        status: 0,
        isCorrect: false,
        selectedAnswer: null,
        chapterId: 0,
      );

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
      answers: answers ?? this.answers,
      status: status ?? this.status,
      isCorrect: isCorrect ?? this.isCorrect,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      chapterId: chapterId ?? this.chapterId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        index,
        text,
        image,
        explain,
        type,
        isImportant,
        vehicle,
        chapter,
        answers,
        status,
        isCorrect,
        selectedAnswer,
        chapterId
      ];

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
      chapter: json['chapter'] == null
          ? null
          : ChapterModel.fromJson(json['chapter'] as Map<String, dynamic>),
      answers: (json['answer'] as List<dynamic>?)
              ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
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
      'answers': answers.map((e) => e.toJson()).toList(),
      'status': status,
      'isCorrect': isCorrect,
      'selectedAnswer': selectedAnswer?.toJson(),
      'chapterId': chapterId,
    };
  }
}
