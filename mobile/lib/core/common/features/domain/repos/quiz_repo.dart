


import '../../../../utils/typedefs.dart';
import '../entities/quiz_entity.dart';

abstract class QuizRepo {
  const QuizRepo();

  ResultFuture<List<QuizEntity>> getQuizzes();

}