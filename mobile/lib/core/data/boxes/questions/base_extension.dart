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
  List<ChapterModel> get listChaptersNew {
    return (box.get(
      BoxKeys.listChaptersNew,
      defaultValue: [],
    ) as List).cast<ChapterModel>();
  }

  set listChaptersNew(List<ChapterModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.listChaptersNew);
      return;
    }
    box.put(BoxKeys.listChaptersNew, value);
  }

  void updateQuestion(QuestionModel question){
    final questions = allQuestions;
    final chapters = listChaptersNew;

    //note: update question
    questions.removeWhere((element) => element.index == question.index && element.vehicle == question.vehicle);
    questions.add(question);
    allQuestions = questions;

    //note: update chapter
    final chapter = chapters.singleWhere((element) => element.id == question.chapterId);
    chapter.questions.removeWhere((element) => element.index == question.index && element.vehicle == question.vehicle);
    chapter.questions.add(question);
    listChaptersNew = [...chapters];
    
  }

}
