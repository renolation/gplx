
import '../common/features/data/models/chapter_model.dart';

List<ChapterModel> addImportantQuestionsToChapter8(List<ChapterModel> listChapter) {
  List<ChapterModel> listChapters = [...listChapter];
  ChapterModel oto = listChapter.firstWhere((element) => element.vehicle == 'Oto' && element.isImportant);
  ChapterModel moto = listChapter.firstWhere((element) => element.vehicle == 'Moto' && element.isImportant);

  for (var chapter in listChapter) {
    for (var question in chapter.questions.where((q) => q.isImportant)) {
      if (question.vehicle == 'Oto' && !oto.questions.contains(question)) {
        oto.questions.add(question);
      } else if (question.vehicle == 'Moto' && !moto.questions.contains(question)) {
        moto.questions.add(question);
      }
    }
  }

  listChapters.removeWhere((element) => (element.vehicle == 'Oto' || element.vehicle == 'Moto') && element.isImportant);
  listChapters.addAll([oto, moto]);

  return listChapters;
}