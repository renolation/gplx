part of 'quiz_bloc.dart';

sealed class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}
class GetQuizByIdEvent extends QuizEvent {
  final int id;

  const GetQuizByIdEvent(this.id);
}

class GetRandomQuizEvent extends QuizEvent {
  const GetRandomQuizEvent();
}

class IncreaseQuestionIndexEvent extends QuizEvent {
  const IncreaseQuestionIndexEvent();
}

class DecreaseQuestionIndexEvent extends QuizEvent {
  const DecreaseQuestionIndexEvent();
}

class SelectAnswerEvent extends QuizEvent {
  const SelectAnswerEvent(this.answer, this.index);

  final AnswerModel answer;
  final int index;
}

class CheckAnswerEvent extends QuizEvent {
  const CheckAnswerEvent();
}

class GoToQuestionEvent extends QuizEvent {
  const GoToQuestionEvent(this.index);
  final int index;
}

class ResultQuizEvent extends QuizEvent {
  final int time;
  const ResultQuizEvent(this.time);
}