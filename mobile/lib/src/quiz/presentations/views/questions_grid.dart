import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/common/features/data/models/question_model.dart';
import '../bloc/quiz_bloc.dart';

class QuestionsGrid extends StatelessWidget {
  const QuestionsGrid({
    super.key,
    this.status,
  });

  final int? status;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<QuizBloc, QuizState, List<QuestionModel>>(
      selector: (state) => (state as QuizFinished).quiz.questions,
      builder: (ctx, questions) {
        List<QuestionModel> listQuestions = status == null
            ? questions
            : questions.where((element) => element.status == status).toList();
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, childAspectRatio: 1,

              mainAxisSpacing: 6,
            crossAxisSpacing: 6
          ),
          itemCount: listQuestions.length,
          itemBuilder: (ctx, i) {
            QuestionModel question = listQuestions[i];
            return Container(
              height: 20,
              width: 20,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                color: question.status == 1
                    ? Colors.green.withOpacity(0.25)
                    : question.status == 2
                    ? Colors.red.withOpacity(0.25)
                    : Colors.white10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Câu ${question.index}'),
                  Icon(
                    question.status == 1
                        ? FontAwesomeIcons.circleCheck
                        : question.status == 2
                            ? FontAwesomeIcons.circleXmark
                            : FontAwesomeIcons.circleInfo,
                    color: question.status == 1
                        ? Colors.green
                        : question.status == 2
                        ? Colors.red
                        : Colors.yellow,
                    size: 20,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
