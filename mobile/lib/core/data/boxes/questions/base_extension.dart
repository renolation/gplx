part of '../../boxes.dart';

extension BaseExtension on QuestionsBox {



  //note: get all questions from box
  List<QuestionModel> get allQuestions {
    return (box.get(
      BoxKeys.allQuestions,
      defaultValue: [],
    ) as List).cast<QuestionModel>();
  }

  //note: set/save all questions to box
  set allQuestions(List<QuestionModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.allQuestions);
      return;
    }
    box.put(BoxKeys.allQuestions, value);
  }



  List<QuestionModel> get wrongQuestions {
    return allQuestions.where((e) => e.status == 2).toList();
  }

  void updateQuestion(QuestionModel question){
    final questions = allQuestions;
    final chapters = listChapters;

    //note: update question
    questions.removeWhere((element) => element.index == question.index && element.vehicle == question.vehicle);
    questions.add(question);
    allQuestions = questions;

    //note: update chapter
    final chapter = chapters.singleWhere((element) => element.id == question.chapterId);
    chapter.questions.removeWhere((element) => element.index == question.index && element.vehicle == question.vehicle);
    chapter.questions.add(question);
    listChapters = [...chapters];
    
  }

}
