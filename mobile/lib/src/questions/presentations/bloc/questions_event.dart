
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

class GetWrongAnswersEvent extends QuestionsEvent {
  const GetWrongAnswersEvent();
}

class GetImportantQuestionsEvent extends QuestionsEvent {
  const GetImportantQuestionsEvent();
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

class GoToQuestionEvent extends QuestionsEvent {
  const GoToQuestionEvent(this.index);
  final int index;
}