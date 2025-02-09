import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';


class AnswerEntity extends Equatable {
  const AnswerEntity({
    required this.id,
    required this.text,
    required this.isCorrect,
    required this.question,
  });

  final int id;
  final String text;
  final bool isCorrect;
  final QuestionEntity question;

  @override
  List<Object?> get props => [id, text, isCorrect, question];
}
