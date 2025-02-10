
part of 'questions_bloc.dart';


abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}


class GetQuestionsEvent extends QuestionsEvent {
  const GetQuestionsEvent();

}