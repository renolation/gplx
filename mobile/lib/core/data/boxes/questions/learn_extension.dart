part of '../../boxes.dart';

extension LearnExtension on QuestionsBox {

  //note: test
  bool get hasFinishedOnboarding {
    return box.get(
      BoxKeys.hasFinishedOnboarding,
      defaultValue: false,
    );
  }
//note: test
  set hasFinishedOnboarding(bool value) {
    box.put(BoxKeys.hasFinishedOnboarding, value);
  }

  //note: get all questions from box
  List<QuestionModel> get listQuestions {
    return (box.get(
      BoxKeys.listQuestions,
      defaultValue: [],
    ) as List).cast<QuestionModel>();
  }

  //note: set/save all questions to box
  set listQuestions(List<QuestionModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.listQuestions);
      return;
    }
    box.put(BoxKeys.listQuestions, value);
  }

  addQuestion(QuestionModel question) {
    final questions = listQuestions;
    questions.add(question);
    listQuestions = questions;
  }

  //note: get question by index and type
  QuestionModel? getIndexTypeQuestion(int index, String type){
    return box.get(
      BoxKeys.listQuestions,
      defaultValue: [],
    ).firstWhere((element) => element.index == index && element.type == type, orElse: () => null);
  }

  //note: update question to box
  updateIndexTypeQuestion(QuestionModel value){
    List<QuestionModel> list = box.get(
      BoxKeys.listQuestions,
      defaultValue: [],
    );
    list.removeWhere((element) => element.index == value.index && element.type == value.type);
    list.add(value);
    box.put(BoxKeys.listQuestions, list);
  }

  void updateQuestion(QuestionModel question) {
    final questions = listQuestions;
    final index = questions.indexWhere((element) => element.id == question.id);
    if (index == -1) addQuestion(question);
    questions[index] = question;
    listQuestions = questions;
  }

  QuestionModel get question {
    return box.get(BoxKeys.question, defaultValue: QuestionModel.empty());
  }

  set question(QuestionModel question) {
      box.put(BoxKeys.question, question);
  }

}
