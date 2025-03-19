import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/src/quizzes/presentations/bloc/quizzes_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../../../../core/common/features/data/models/quiz_model.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ đề thi'),
        actions: [
          IconButton(onPressed: (){
            QuestionsBox().deleteQuizzes();
          }, icon: Icon(FontAwesomeIcons.deleteLeft)),
        ],
      ),
      body: BlocBuilder<QuizzesBloc, QuizzesState>(
        builder: (context, state) {
          if (state is QuizzesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizzesLoaded) {
            return ValueListenableBuilder(valueListenable: Hive.box(BoxKeys.hiveQuestionsBox).listenable(), builder: (context, box, _){
              List<QuizModel> listQuizzes = QuestionsBox().listQuizzes.isEmpty ? state.quizzes : QuestionsBox().listQuizzes;
              listQuizzes.sort((a, b) => a.id.compareTo(b.id));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: listQuizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = listQuizzes[index];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed('quiz',
                            pathParameters: {'quizId': '${quiz.id}'});
                      },
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: quiz.status != 0 ? Colors.red : Colors.grey.withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                    child: Text(quiz.name, style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),)),
                              ),
                            ),
                            Container(
                              height: 70,
                              child: Center(
                                  child: quiz.status != 0 ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    spacing: 8,
                                    children: [
                                      const SizedBox(width: 8,),
                                      const Icon(FontAwesomeIcons.circleCheck, color: Colors.green,),
                                      Text('${quiz.correctCount}'),
                                      const Icon(FontAwesomeIcons.circleXmark, color: Colors.red,),
                                      Text('${quiz.incorrectCount}'),
                                      const SizedBox(width: 8,),
                                    ],
                                  ) : SizedBox()),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            });
          } else if (state is QuizzesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No quizzes available'));
          }
        },
      ),
    );
  }
}
