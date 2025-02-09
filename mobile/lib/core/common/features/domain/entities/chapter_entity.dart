import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';


class ChapterEntity extends Equatable {
  const  ChapterEntity(
  {
    required this.id,
    required this.index,
    required this.name,
    required this.questions,
});

  final int id;
  final int index;
  final String name;
  final List<QuestionEntity> questions;

  @override
  List<Object?> get props => [id, index, name, questions];


}
