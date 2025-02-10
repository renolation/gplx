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

  const QuestionsLoaded(this.questions);

  @override
  List<Object> get props => [questions];
}

class QuestionsError extends QuestionsState {
  final String message;

  const QuestionsError(this.message);

  @override
  List<Object> get props => [message];
}