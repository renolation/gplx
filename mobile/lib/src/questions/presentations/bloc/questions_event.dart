
part of 'questions_bloc.dart';


abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object> get props => [];
}


class GetQuestionsEvent extends QuestionsEvent {
  const GetQuestionsEvent();
}

class GetQuestionsByChapterIdEvent extends QuestionsEvent {
  const GetQuestionsByChapterIdEvent(this.chapterId);

  final int chapterId;
}