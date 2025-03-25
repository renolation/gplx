
import '../common/features/data/models/chapter_model.dart';
import '../common/features/data/models/question_model.dart';

List<ChapterModel> addImportantQuestionsToChapter8(List<ChapterModel> listChapter) {
  List<ChapterModel> listChapters = [...listChapter];
  ChapterModel oto = listChapter.firstWhere((e) => e.vehicle == 'Oto' && e.isImportant);
  ChapterModel moto = listChapter.firstWhere((e) => e.vehicle == 'Moto' && e.isImportant);
  ChapterModel allOto = listChapter.firstWhere((e) => e.vehicle == 'Oto' && e.index == 0);
  ChapterModel allMoto = listChapter.firstWhere((e) => e.vehicle == 'Moto' && e.index == 0);

  List<QuestionModel> otoQuestionsToAdd = [];
  List<QuestionModel> motoQuestionsToAdd = [];
  List<QuestionModel> allOtoQuestionsToAdd = [];
  List<QuestionModel> allMotoQuestionsToAdd = [];

  for (var chapter in listChapter) {
    for (var question in chapter.questions) {
      if (question.isImportant) {
        if (question.vehicle == 'Oto' && !oto.questions.contains(question)) otoQuestionsToAdd.add(question);
        if (question.vehicle == 'Moto' && !moto.questions.contains(question)) motoQuestionsToAdd.add(question);
      }
      if (question.vehicle == 'Oto') allOtoQuestionsToAdd.add(question);
      if (question.vehicle == 'Moto') allMotoQuestionsToAdd.add(question);
    }
  }

  oto.questions.addAll(otoQuestionsToAdd);
  moto.questions.addAll(motoQuestionsToAdd);
  allOto.questions.addAll(allOtoQuestionsToAdd);
  allMoto.questions.addAll(allMotoQuestionsToAdd);

  listChapters.removeWhere((e) => e.index == 0 || e.isImportant);
  listChapters.addAll([allOto, allMoto, oto, moto]);
  listChapters.sort((a, b) => a.index.compareTo(b.index));

  return listChapters;
}