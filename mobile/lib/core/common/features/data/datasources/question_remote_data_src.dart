

import 'dart:convert';

import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/errors/exceptions.dart';
import 'package:gplx_app/core/utils/enums.dart';
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
      final questions = QuestionsBox().listQuestions;
      if(questions.isEmpty){
        final data = await _client
            .from('question')
            .select('*, answer(*), chapter(*)');
        print(data);
        String jsonString = jsonEncode(data);
        final jsonData = questionModelFromJson(jsonString);
        QuestionsBox().listQuestions = jsonData;
        return jsonData;
      } else {
        return questions;
      }

    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<QuestionModel>> getQuestionsByChapterId(int chapterId) async {
    try {
      final chapter = QuestionsBox().getChapterById(chapterId);
      if(chapter != null){
        return chapter.questions;
      }
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
      List<QuestionModel> list =
      QuestionsBox().wrongQuestions
          .where((e) {
        return e.vehicle == SettingsBox().vehicleTypeQuestion.convertToVehicle();
      }
      ).toList();
      if(list.isEmpty){
        return [];
      }
      return list;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}