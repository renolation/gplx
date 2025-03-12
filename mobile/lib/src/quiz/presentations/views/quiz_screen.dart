import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/features/data/models/answer_model.dart';
import '../../../../core/common/features/data/models/question_model.dart';
import '../bloc/quiz_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Scaffold(
            extendBodyBehindAppBar: true,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is QuizFinished) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quizzes'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Quiz completed'),
                    Container(
                      height: 30,
                      child: Row(
                        children: [
                          Text('Correct: ${state.quiz.correctCount}'),
                          Text('Wrong: ${state.quiz.incorrectCount}'),
                          Text('Total: ${state.quiz.questions.length}'),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const TabBar(
                            tabs: [
                              Tab(text: 'Correct'),
                              Tab(text: 'Wrong'),
                              Tab(text: 'Did not answer'),
                            ],
                          ),
                          Container(
                            height: 100,
                            child: const TabBarView(
                              children: [
                                Text('a'),
                                Text('a'),
                                Text('a'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is QuizLoaded) {
          final index = state.index;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<QuizBloc>().add(const ResultQuizEvent());
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: state.quiz.questions.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap: () => context.read<QuizBloc>().add(GoToQuestionEvent(i)),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 40,
                            color: i == index ? Colors.red : Colors.blue,
                            child: Center(child: Text('Câu ${state.quiz.questions[i].index}')),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(const DecreaseQuestionIndexEvent());
                    },
                    child: const Text('Previous'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(const IncreaseQuestionIndexEvent());
                    },
                    child: const Text('Next'),
                  ),
                  Text('Câu: ${state.quiz.questions[index].index}'),
                  Text(state.quiz.questions[index].text),
                  Text('$index'),
                  Text((state.quiz.questions[index] as QuestionModel).selectedAnswer?.text ?? 'Empty'),
                  Column(
                    children: [
                      for (final answer in state.quiz.questions[index].answers!)
                        ListTile(
                          title: Text(' ${answer.isCorrect} ${answer.text}'),
                          leading: Radio<AnswerModel>(
                            value: answer as AnswerModel,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                final question = state.quiz.questions[index] as QuestionModel;
                                return answer.id == question.selectedAnswer?.id
                                    ? Colors.green
                                    : Colors.black;
                              },
                            ),
                            groupValue: (state.quiz.questions[index] as QuestionModel).selectedAnswer,
                            onChanged: (value) {
                              context.read<QuizBloc>().add(SelectAnswerEvent(value!, index));
                            },
                          ),
                        ),
                    ],
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     context.read<QuizBloc>().add(const CheckAnswerEvent());
                  //   },
                  //   child: const Text('Check answer'),
                  // ),
                  // state.quiz.questions[index].status == 0
                  //     ? const SizedBox()
                  //     : Text(state.quiz.questions[index].explain),
                ],
              ),
            ),
          );
        } else if (state is QuizError) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            body: Center(child: Text(state.message)),
          );
        } else {
          return const Scaffold(
            extendBodyBehindAppBar: true,
            body: Center(child: Text('No quiz available')),
          );
        }
      },
    );
  }
}