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
        } else if (state is QuizLoaded) {
          //note: body
          final index = state.index;
          return state.quiz.status  == 1 ? Scaffold(
            appBar: AppBar(
              title: const Text('Quizzes'),
            ),
            body:  Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Quiz completed'),
                    Row(
                      children: [
                        Text('Correct: ${state.quiz.correctCount}'),
                        Text('Wrong: ${state.quiz.incorrectCount}'),
                        Text('Total: ${state.quiz.questions.length}'),
                      ],
                    ),
                    TabBar(tabs: [
                      Tab(text: 'Correct'),
                      Tab(text: 'Wrong'),
                      Tab(text: 'Did not answer'),
                    ]),
                    TabBarView(children: [
                      ListView.builder(
                        itemCount: state.quiz.questions.length,
                        itemBuilder: (ctx, i) {
                          final question = state.quiz.questions[i] as QuestionModel;
                          if (question.status == 1) {
                            return ListTile(
                              title: Text('Câu ${question.index}'),
                              subtitle: Text(question.text),
                              trailing: Icon(Icons.check, color: Colors.green),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      ListView.builder(
                        itemCount: state.quiz.questions.length,
                        itemBuilder: (ctx, i) {
                          final question = state.quiz.questions[i] as QuestionModel;
                          if (question.status == 2) {
                            return ListTile(
                              title: Text('Câu ${question.index}'),
                              subtitle: Text(question.text),
                              trailing: Icon(Icons.close, color: Colors.red),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      ListView.builder(
                        itemCount: state.quiz.questions.length,
                        itemBuilder: (ctx, i) {
                          final question = state.quiz.questions[i] as QuestionModel;
                          if (question.status == 0) {
                            return ListTile(
                              title: Text('Câu ${question.index}'),
                              subtitle: Text(question.text),
                              trailing: Icon(Icons.close, color: Colors.red),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ) : Scaffold(
            appBar: AppBar(
              title: const Text('Quiz'),
            ),
            body:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: state.quiz.questions.length,
                      scrollDirection: Axis.horizontal,
                      // controller: scrollController,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap:() => context.read<QuizBloc>().add(GoToQuestionEvent(i)),
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
                    child: Text('Previous'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(const IncreaseQuestionIndexEvent());
                    },
                    child: Text('Next'),
                  ),
                  Text('Câu: ${state.quiz.questions[index].index}'),
                  Text('${state.quiz.questions[index].text}'),
                  Container(
                    child: Column(
                      children: [
                        for (final answer in state.quiz.questions[index].answers!)
                          ListTile(
                            title: Text(' ${answer.isCorrect} ${answer.text}'),
                            leading: Radio<AnswerModel>(
                              value: answer as AnswerModel,
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                      QuestionModel question = state.quiz.questions[index] as QuestionModel;
                                  if (question.status == 0) {
                                    return Colors.black; // Default color before selection
                                  }
                                  return answer.isCorrect
                                      ? Colors.green
                                      : (answer == question.selectedAnswer ? Colors.red : Colors.black);
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
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(const CheckAnswerEvent());
                    },
                    child: Text('Check answer'),
                  ),
                  (state.quiz.questions[index] as QuestionModel).status == 0 ? const SizedBox() : Text((state.quiz.questions[index] as QuestionModel).explain),
                ],
              ),
            ),
          );
          return Text(state.quiz.name);
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
