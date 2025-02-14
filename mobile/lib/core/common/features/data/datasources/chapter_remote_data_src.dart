

import 'dart:convert';

import 'package:gplx_app/core/common/features/data/models/chapter_model.dart';
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
      final data = await _client
          .from('chapter')
          .select();
      print(data);
      String jsonString = jsonEncode(data);

      return chapterModelFromJson(jsonString);
    } on ServerException {
      rethrow;
    } catch (e){
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}