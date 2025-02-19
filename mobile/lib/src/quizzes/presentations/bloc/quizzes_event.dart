part of 'quizzes_bloc.dart';

@immutable
sealed class QuizzesEvent  extends Equatable{

  const QuizzesEvent();

  @override
  List<Object> get props => [];
}


class GetQuizzesEvent extends QuizzesEvent {
  const GetQuizzesEvent();
}