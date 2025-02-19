part of 'quizzes_bloc.dart';

abstract class QuizzesState {

  const QuizzesState();

  @override
  List<Object> get props => [];
}

final class QuizzesInitial extends QuizzesState {}

final class QuizzesLoading extends QuizzesState {}

final class QuizzesLoaded extends QuizzesState {
  final List<QuizModel> quizzes;

  const QuizzesLoaded(this.quizzes);

  @override
  List<Object> get props => [quizzes];
}

final class QuizzesError extends QuizzesState {
  final String message;

  const QuizzesError(this.message);

  @override
  List<Object> get props => [message];
}