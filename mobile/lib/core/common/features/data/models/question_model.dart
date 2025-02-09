import 'package:equatable/equatable.dart';
import '../../domain/entities/question_entity.dart';
import 'chapter_model.dart';
import 'answer_model.dart';

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
    required ChapterModel chapter,
    List<AnswerModel> answers = const [],
  }) : super(
    chapter: chapter,
    answers: answers,
  );

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
      chapter: ChapterModel.fromJson(json['chapter'] as Map<String, dynamic>),
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
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
      'answers': answers.map((e) => (e as AnswerModel).toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => super.props;
}
