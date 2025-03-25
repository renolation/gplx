part of '../../boxes.dart';

extension LearnExtension on QuestionsBox {


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

  List<ChapterModel> get listChapters {
    return (box.get(
      BoxKeys.listChapters,
      defaultValue: [],
    ) as List).cast<ChapterModel>();
  }

  set listChapters(List<ChapterModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.listChapters);
      return;
    }
    box.put(BoxKeys.listChapters, value);
  }




  ChapterModel? getChapterById(int chapterId) {
    print('aaa');
    return listChapters.singleWhere((e) => e.id == chapterId);
  }


}
