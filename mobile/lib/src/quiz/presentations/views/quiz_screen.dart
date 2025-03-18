import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/common/features/data/models/quiz_model.dart';
import 'package:gplx_app/src/quiz/presentations/bloc/counter_cubit.dart';
import 'package:gplx_app/src/quiz/presentations/views/counter_widget.dart';
import 'package:gplx_app/src/quiz/presentations/views/questions_grid.dart';

import '../../../../core/common/features/data/models/answer_model.dart';
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
          return DefaultTabController(
            length: 4,

            child: Scaffold(
              appBar: AppBar(
                title: const Text('Quizzes'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Khong dat'),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Correct: ${state.quiz.correctCount}'),
                            Text('Wrong: ${state.quiz.incorrectCount}'),
                            Text('No answer: ${state.quiz.didNotAnswerCount}'),
                            Text('Total: ${state.quiz.questions.length}'),
                          ],
                        ),
                      ),
                       TabBar(
                        tabs: const [
                          Tab(text: 'Total'),
                          Tab(text: 'Correct'),
                          Tab(text: 'Wrong'),
                          Tab(text: 'Did not answer'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  TabBarView(
                  children: const [
                    QuestionsGrid(),
                    QuestionsGrid(status: 1),
                    QuestionsGrid(status: 2),
                    QuestionsGrid(status: 0),
                  ],
                ),
              ),
            ),
          );
        } else if (state is QuizLoaded) {
          final index = state.index;
          return Scaffold(
            appBar: AppBar(
              title: CounterWidget(),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<QuizBloc>().add(const ResultQuizEvent());
                  },
                  icon: const Icon(Icons.refresh),
                ),
                TextButton(onPressed: (){
                  // print(context.read<CounterCubit>().time);
                }, child: Text('Submit')),
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
                          onTap: () => context
                              .read<QuizBloc>()
                              .add(GoToQuestionEvent(i)),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 40,
                            color: i == index ? Colors.red : Colors.blue,
                            child: Center(
                                child: Text(
                                    'Câu ${i+1}')),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<QuizBloc>()
                          .add(const DecreaseQuestionIndexEvent());
                    },
                    child: const Text('Previous'),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<QuizBloc>()
                          .add(const IncreaseQuestionIndexEvent());
                    },
                    child: const Text('Next'),
                  ),
                  Text('Câu: ${index + 1}'),
                  Text(state.quiz.questions[index].text),
                  Column(
                    children: [
                      for (final answer in state.quiz.questions[index].answers)
                        ListTile(
                          title: Text(' ${answer.isCorrect} ${answer.text}'),
                          leading: Radio<AnswerModel>(
                            value: answer,
                            fillColor: WidgetStateProperty.resolveWith<Color>(
                              (states) {
                                final question = state.quiz.questions[index];
                                if (question.status == 0) {
                                  return Colors
                                      .black; // Default color before selection
                                }
                                return answer.isCorrect
                                    ? Colors.green
                                    : (answer == question.selectedAnswer
                                        ? Colors.red
                                        : Colors.black);
                              },
                            ),
                            groupValue:
                                (state.quiz.questions[index]).selectedAnswer,
                            onChanged: (value) {
                              context
                                  .read<QuizBloc>()
                                  .add(SelectAnswerEvent(value!, index));
                            },
                          ),
                        ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(const CheckAnswerEvent());
                    },
                    child: const Text('Check answer'),
                  ),
                  state.quiz.questions[index].status == 0
                      ? const SizedBox()
                      : Text(state.quiz.questions[index].explain),
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

