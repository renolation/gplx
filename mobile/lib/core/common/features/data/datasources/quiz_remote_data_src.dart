

import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../errors/exceptions.dart';
import '../models/chapter_model.dart';
import '../models/quiz_model.dart';

abstract class QuizRemoteDataSrc {
  const QuizRemoteDataSrc();

  Future<List<QuizModel>> getQuizzes();
  
  Future<QuizModel> getQuizById(int quizId);
}


class QuizRemoteDataSrcImpl extends QuizRemoteDataSrc {
  const QuizRemoteDataSrcImpl({
    required SupabaseClient client,
  }) : _client = client;

  final SupabaseClient _client;

  @override
  Future<List<QuizModel>> getQuizzes() async {
    try {
      final data = await _client
          .from('quiz')
          .select('*, question(*)');
      // print(data);
      String jsonString = jsonEncode(data);
      return quizModelFromJson(jsonString);
    }on ServerException {
      rethrow;
    } catch (e){
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<QuizModel> getQuizById(int quizId) async {
    try {
      final data = await _client
          .from('quiz')
          .select('*, question(*, answer(*))')
          .eq('id', quizId)
          .limit(1);
      // print(data);
      String jsonString = jsonEncode(data);
      return quizModelFromJson(jsonString).first;
    }on ServerException {
      rethrow;
    } catch (e){
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}