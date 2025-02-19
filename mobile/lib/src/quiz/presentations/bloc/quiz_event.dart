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