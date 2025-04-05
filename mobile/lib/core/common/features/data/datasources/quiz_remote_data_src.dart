import 'dart:convert';

import 'package:gplx_app/core/utils/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data/boxes.dart';
import '../../../../errors/exceptions.dart';
import '../models/chapter_model.dart';
import '../models/question_model.dart';
import '../models/quiz_model.dart';

abstract class QuizRemoteDataSrc {
  const QuizRemoteDataSrc();

  Future<List<QuizModel>> getQuizzes();

  Future<QuizModel> getQuizById(int quizId);

   Future<QuizModel> getRandomQuiz();
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
      quizzes.sort((a, b) => a.id.compareTo(b.id));
      if (quizzes.isNotEmpty) {
        return quizzes;
      }
      final data =
          await _client.from('quiz').select('*, question(*, answer(*))');
      String jsonString = jsonEncode(data);
      final fetchedQuizzes = quizModelFromJson(jsonString);
      QuestionsBox().listQuizzes = fetchedQuizzes;
      return fetchedQuizzes;
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
      final quiz = QuestionsBox().getQuizById(quizId);
      if (quiz == null) {
        final data = await _client
            .from('quiz')
            .select('*, question(*, answer(*))')
            .eq('id', quizId)
            .limit(1);

        String jsonString = jsonEncode(data);
        return quizModelFromJson(jsonString).first;
      }
      quiz.questions.asMap().forEach((i, question) {
        // question.index = i + 1;
        quiz.questions[i] = question.copyWith(index: i + 1);
      });
      return quiz;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<QuizModel> getRandomQuiz() async {
    try {
      // final questions = QuestionsBox().listQuestions;
      final data = await _client.from('question').select('*, answer(*), chapter(*)');
      print(data);
      String jsonString = jsonEncode(data);
      final jsonData = questionModelFromJson(jsonString);
      QuestionsBox().listQuestions = jsonData;
      var questions = QuestionsBox().listQuestions;
      questions = questions.where((e) => e.vehicle == SettingsBox().vehicleTypeQuestion.convertToVehicle()).toList();
      QuizModel quiz = QuizModel(
        id: 0,
        name: 'Đề thi ngẫu nhiên',
        type: SettingsBox().vehicleTypeQuestion,
        questions: [], isTested: false, correctCount: 0,
        status: 0,
        time_used: 0, incorrectCount: 0, time_to_do: 1800,
      );

      print(questions.length);
      List<QuestionModel> listQuestions = [];
      final chapter1 = questions.where((e) => e.chapterId == 1).toList();
      chapter1.shuffle();
      listQuestions.addAll(chapter1.take(8).toList());


      final chapter3 = questions.where((e) => e.chapterId == 3).toList();
      chapter3.shuffle();
      listQuestions.addAll(chapter3.take(1).toList());

      final chapter4 = questions.where((e) => e.chapterId == 4).toList();
      chapter4.shuffle();
      listQuestions.addAll(chapter4.take(1).toList());

      final chapter5 = questions.where((e) => e.chapterId == 5).toList();
      chapter5.shuffle();
      listQuestions.addAll(chapter5.take(1).toList());

      final chapter6 = questions.where((e) => e.chapterId == 6).toList();
      chapter6.shuffle();
      listQuestions.addAll(chapter6.take(9).toList());

      final chapter7 = questions.where((e) => e.chapterId == 7).toList();
      chapter7.shuffle();
      listQuestions.addAll(chapter7.take(9).toList());

      final chapter8 = questions.where((e) => e.isImportant == true).toList();
      chapter8.shuffle();
      if(listQuestions.contains(chapter8[0])) {
        listQuestions.add(chapter8[0]);
      } else {
        listQuestions.add(chapter8[1]);
      }

      quiz = quiz.copyWith(
        questions: listQuestions,
      );


      return quiz;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 505);
    }
  }
}
