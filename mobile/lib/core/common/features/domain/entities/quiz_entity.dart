import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';

class QuizEntity extends Equatable {

  const QuizEntity({
    required this.id,
    required this.isTested,
    required this.correctCount,
    required this.incorrectCount,
    required this.didNotAnswerCount,
    required this.status,
    required this.type,
    required this.name,
    required this.time_to_do,
    required this.time_used,
    this.questions = const [],
  });


 final int id;
 final bool isTested;
 final int? correctCount;
 final int? incorrectCount;
 final int? didNotAnswerCount;
 final int? status;
 final String type;
 final String name;
 final int time_to_do;
  final int time_used;
  final List<QuestionEntity> questions;

  @override
  List<Object?> get props => [
    id,
    isTested,
    correctCount,
    incorrectCount,
    didNotAnswerCount,
    status,
    type,
    name,
    time_to_do,
    time_used,
  ];
}