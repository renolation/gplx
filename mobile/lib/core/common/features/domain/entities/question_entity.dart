import 'package:equatable/equatable.dart';
import 'answer_entity.dart';
import 'chapter_entity.dart';

class QuestionEntity extends Equatable {
  const QuestionEntity({
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
  });

  final int id;
  final int index;
  final String text;
  final String? image;
  final String? explain;
  final String? type;
  final bool isImportant;
  final String vehicle;
  final ChapterEntity? chapter;
  final List<AnswerEntity>? answers;

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
  ];
}
