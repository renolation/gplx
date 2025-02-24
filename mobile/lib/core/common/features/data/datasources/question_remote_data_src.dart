

import 'dart:convert';

import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/question_model.dart';

abstract class QuestionRemoteDataSrc {
  const QuestionRemoteDataSrc();

  Future<List<QuestionModel>> getQuestions();

  Future<List<QuestionModel>> getQuestionsByChapterId(int chapterId);

  Future<List<QuestionModel>> getWrongAnswers();

}

class QuestionRemoteDataSrcImpl extends QuestionRemoteDataSrc {
  const QuestionRemoteDataSrcImpl({
    required SupabaseClient client,
}) : _client = client;

  final SupabaseClient _client;

  @override
  Future<List<QuestionModel>> getQuestions() async {
    try {
      final data = await _client
          .from('question')
          .select('*, answer(*), chapter(*)');
      print(data);
      String jsonString = jsonEncode(data);

      final jsonData = questionModelFromJson(jsonString);
      return jsonData;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<QuestionModel>> getQuestionsByChapterId(int chapterId) async {
    try {
      final data = await _client
          .from('question')
          .select('*, answer(*), chapter(*)')
          .eq('chapterId', chapterId);
      print(data);
      String jsonString = jsonEncode(data);

      final jsonData = questionModelFromJson(jsonString);
      return jsonData;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<QuestionModel>> getWrongAnswers() async {
    try {
      return QuestionsBox().wrongQuestions;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}