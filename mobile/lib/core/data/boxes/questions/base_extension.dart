part of '../../boxes.dart';

extension BaseExtension on QuestionsBox {



  List<QuestionModel> get allQuestions {
    return (box.get(
      BoxKeys.allQuestions,
      defaultValue: [],
    ) as List)
        .cast<QuestionModel>();
  }

  set allQuestions(List<QuestionModel> value) {
    if (value.isEmpty) {
      box.delete(BoxKeys.allQuestions);
      return;
    }
    box.put(BoxKeys.allQuestions, value);
  }
}
