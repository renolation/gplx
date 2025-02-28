part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();
  @override
  List<Object> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<QuestionModel> questions;
  final int index;

  const QuestionsLoaded(this.questions,{this.index = 0});

  QuestionsLoaded copyWith({List<QuestionModel>? questions, int? index}) {
    return QuestionsLoaded(
      questions ?? this.questions,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [questions, index];
}

class QuestionsError extends QuestionsState {
  final String message;

  const QuestionsError(this.message);

  @override
  List<Object> get props => [message];
}