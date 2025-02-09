import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/entities/chapter_entity.dart';
import 'question_model.dart';

class ChapterModel extends ChapterEntity {


  const ChapterModel({
    required super.id,
    required super.index,
    required super.name,
    super.questions = const [],
  });

   ChapterModel copyWith({
    int? id,
    int? index,
    String? name,
    List<QuestionModel>? questions,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      index: index ?? this.index,
      name: name ?? this.name,
      questions: questions ?? this.questions,
    );
  }

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
      'questions': questions.map((e) => (e as QuestionModel).toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, index, name, questions];
}
