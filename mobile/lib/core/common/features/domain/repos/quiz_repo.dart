


import '../../../../utils/typedefs.dart';
import '../entities/quiz_entity.dart';

abstract class QuizRepo {
  const QuizRepo();

  ResultFuture<List<QuizEntity>> getQuizzes();

  ResultFuture<QuizEntity> getQuizById(int quizId);

  ResultFuture<QuizEntity> getRandomQuiz();

}