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
    return listChapters.singleWhere((e) => e.id == chapterId && e.vehicle == SettingsBox().vehicleTypeQuestion.convertToVehicle());
  }

  void resetChapterById(int chapterId) {
   print('aaa');
    final chapter = getChapterById(chapterId);
    print(chapter);
    if (chapter != null) {
      var questions = [...chapter.questions];
      questions = questions.map((element) => element.copyWith(status: 0, selectedAnswer: null)).toList();
      final updatedChapter = chapter.copyWith(questions: questions);
      final chapters = listChapters;
      chapters.removeWhere((element) => element.id == chapterId);
      chapters.add(updatedChapter);
      listChapters = [...chapters];

      final allQuestionsChapter = listChapters.firstWhere((element) => element.index == 0 && element.vehicle == SettingsBox().vehicleTypeQuestion.convertToVehicle());
      var allQuestions = [...allQuestionsChapter.questions.where((element) => element.chapterId == chapterId)];
      allQuestions = allQuestions.map((element) => element.copyWith(status: 0, selectedAnswer: null)).toList();
      final updatedAllQuestionsChapter = allQuestionsChapter.copyWith(questions: allQuestions);
      final allChapters = listChapters;
      allChapters.removeWhere((element) => element.id == allQuestionsChapter.id);
      allChapters.add(updatedAllQuestionsChapter);
      listChapters = [...allChapters];

    }
  }


}
