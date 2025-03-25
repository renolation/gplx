import 'dart:convert';

import 'package:gplx_app/core/common/features/data/models/chapter_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../utils/functions.dart';

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
          .select('*, question(*, answer(*))');
      String jsonString = jsonEncode(data);
      List<ChapterModel> listChapter = chapterModelFromJson(jsonString);
      listChapter = addImportantQuestionsToChapter8(listChapter);
      QuestionsBox().listChapters = listChapter;
      return listChapter;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}


