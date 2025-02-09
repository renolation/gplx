import 'package:equatable/equatable.dart';
import 'question_model.dart';

class ChapterModel extends Equatable {
  final int id;
  final int index;
  final String name;
  final List<QuestionModel> questions;

  const ChapterModel({
    required this.id,
    required this.index,
    required this.name,
    this.questions = const [],
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] as int,
      index: json['index'] as int,
      name: json['name'] as String,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'name': name,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, index, name, questions];
}
