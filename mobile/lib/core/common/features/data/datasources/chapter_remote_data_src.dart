import 'dart:convert';

import 'package:gplx_app/core/common/features/data/models/chapter_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChapterRemoteDataSrc {
  const ChapterRemoteDataSrc();

  Future<List<ChapterModel>> getChapters();
}

class ChapterRemoteDataSrcImpl extends ChapterRemoteDataSrc {
  const ChapterRemoteDataSrcImpl({
    required SupabaseClient client,
  }) : _client = client;

  final SupabaseClient _client;

  @override
  Future<List<ChapterModel>> getChapters() async {
    try {
      final chapters = QuestionsBox().listChapters;
      if(chapters.isNotEmpty){
        return chapters;
      }
      final data = await _client
          .from('chapter')
          .select('*, question(*, answer(*))')
          .eq('vehicle', 'Oto');
      // print(data);
      String jsonString = jsonEncode(data);
      List<ChapterModel> listChapter = chapterModelFromJson(jsonString);
      listChapter[listChapter.length - 1] = listChapter.last.copyWith(questions: addImportantQuestionsToChapter8(listChapter));
      QuestionsBox().listChapters = listChapter;
      return listChapter;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}

List<QuestionModel> addImportantQuestionsToChapter8(List<ChapterModel> listChapter) {

  List<QuestionModel> listQuestion = [];

  for (var chapter in listChapter) {
    for (var question in chapter.questions) {
      if (question.isImportant) {
        listQuestion.add(question);
      }
    }
  }
  return listQuestion;
}
