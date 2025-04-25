part of '../../boxes.dart';

extension QuizExtension on QuestionsBox {
  List<QuizModel> get listQuizzes {
    return (box.get(
      BoxKeys.listQuizzes,
      defaultValue: [],
    ) as List)
        .cast<QuizModel>();
  }

  set listQuizzes(List<QuizModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.listQuizzes);
      return;
    }
    box.put(BoxKeys.listQuizzes, value);
  }

  void updateQuiz(QuizModel quiz) {
    final quizzes = listQuizzes;
    quizzes.removeWhere((element) => element.id == quiz.id);
    quizzes.add(quiz);
    listQuizzes = [...quizzes];
  }

  void deleteQuizzes() {
    listQuizzes = [];
  }


  QuizModel? getQuizById(int quizId) {
    return listQuizzes.singleWhere((e) => e.id == quizId);
  }
}
