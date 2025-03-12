import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data/boxes.dart';
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
      final quizzes = QuestionsBox().listQuizzes;
      if (quizzes.isEmpty) {
        final data = await _client.from('quiz').select('*, question(*)');
        String jsonString = jsonEncode(data);
        final fetchedQuizzes = quizModelFromJson(jsonString);
        QuestionsBox().listQuizzes =
            fetchedQuizzes; // Save fetched quizzes to Hive
        return fetchedQuizzes;
      } else {
        return quizzes;
      }
    } on ServerException {
      rethrow;
    } on CacheException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<QuizModel> getQuizById(int quizId) async {
    try {
      print('id $quizId');
      // final quiz = QuestionsBox().getQuizById(quizId);
      // if(quiz == null){
        final data = await _client
            .from('quiz')
            .select('*, question(*, answer(*))')
            .eq('id', quizId)
            .limit(1);

        String jsonString = jsonEncode(data);
        return quizModelFromJson(jsonString).first;
      // }
      // return quiz;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
