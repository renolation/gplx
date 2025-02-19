part of 'quiz_bloc.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];

}

final class QuizInitial extends QuizState {

}


final class QuizLoading extends QuizState {

}

final class QuizLoaded extends QuizState {
  final QuizModel quiz;

  const QuizLoaded(this.quiz);

  @override
  List<Object> get props => [quiz];
}

final class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object> get props => [message];
}