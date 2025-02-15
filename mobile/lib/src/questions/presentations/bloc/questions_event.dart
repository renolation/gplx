
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

class IncreaseQuestionIndexEvent extends QuestionsEvent {
  const IncreaseQuestionIndexEvent();
}

class DecreaseQuestionIndexEvent extends QuestionsEvent {
  const DecreaseQuestionIndexEvent();
}

class SelectAnswerEvent extends QuestionsEvent {
  const SelectAnswerEvent(this.answer, this.index);

  final AnswerModel answer;
  final int index;
}

class CheckAnswerEvent extends QuestionsEvent {
  const CheckAnswerEvent();
}