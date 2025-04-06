import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/common/features/data/models/quiz_model.dart';
import 'package:gplx_app/core/utils/colors.dart';
import 'package:gplx_app/src/quiz/presentations/bloc/counter_cubit.dart';
import 'package:gplx_app/src/quiz/presentations/views/counter_widget.dart';
import 'package:gplx_app/src/quiz/presentations/views/questions_grid.dart';
import 'package:gplx_app/src/quizzes/presentations/bloc/quizzes_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/ads/banner_ad.dart';
import '../../../../core/common/features/data/models/answer_model.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/explain_widget.dart';
import '../bloc/quiz_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

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
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
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
                            Text('Time: ${state.quiz.time_used}'),
                            Text('${state.quiz.correctCount}/${state.quiz.questions.length}'),
                          ],
                        ),
                      ),
                       TabBar(
                        tabs:  [
                          Tab(text: 'Total ${state.quiz.questions.length}'),
                          Tab(text: 'Correct ${state.quiz.correctCount}'),
                          Tab(text: 'Wrong ${state.quiz.incorrectCount}'),
                          Tab(text: 'Did not answer ${state.quiz.didNotAnswerCount}'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body:const Padding(
                padding:  EdgeInsets.all(8.0),
                child:  TabBarView(
                  children:  [
                    QuestionsGrid(),
                    QuestionsGrid(status: 1),
                    QuestionsGrid(status: 2),
                    QuestionsGrid(status: 0),
                  ],
                ),
              ),
              // bottomSheet: Padding(
              //   padding:  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              //   child: const AnchoredAdaptiveExample(),
              // ),
            ),
          );
        } else if (state is QuizLoaded) {
          final index = state.index;

          return Scaffold(
            appBar: AppBar(
              title: BlocProvider.value(value: context.read<CounterCubit>(), child: const CounterWidget()),
              leading: const SizedBox(),
              actions: [
                TextButton(onPressed: (){
                  showDialog(context: context, builder: (ctx) => AlertDialog(
                    title: const Text('Submit quiz'),
                    content: const Text('Are you sure you want to submit the quiz?'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child: const Text('No')),
                      TextButton(onPressed: (){
                        int time = context.read<CounterCubit>().time;
                        context.read<QuizBloc>().add(ResultQuizEvent(time));
                        Navigator.of(context).pop();
                      }, child: const Text('Yes')),
                    ],
                  ));
                }, child: const Text('Submit', style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),)),
              ],
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: state.quiz.questions.length,
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    itemBuilder: (ctx, i) {
                      QuestionModel question = state.quiz.questions[i];
                      return InkWell(
                        onTap: () => context
                            .read<QuizBloc>()
                            .add(GoToQuestionEvent(i)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 2,
                                  color: i == index && question.status == 0 ? Colors.blue : Colors.transparent),
                            ),
                            color: question.status == 2
                                ? Colors.red.withValues(alpha: 0.7)
                                : question.status == 1
                                ? Colors.green.withValues(alpha: 0.7)
                                : Colors.transparent,
                          ),
                          child: Center(child: Text('Câu ${state.quiz.questions[i].index}')),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Câu hỏi ${state.quiz.questions[index].index}: ${state.quiz.questions[index].text}',
                      style: kQuestionText),
                ),
                if (state.quiz.questions[index].image!.isNotEmpty)
                  Image.network('https://taplaixe.vn${state.quiz.questions[index].image!}'),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        for (final answer in state.quiz.questions[index].answers)
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                            margin: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () {
                                context.read<QuizBloc>().add(SelectAnswerEvent(answer, index));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Radio<AnswerModel>(
                                    value: answer,
                                    fillColor: WidgetStateProperty.resolveWith<Color>(
                                          (states) {
                                        if (state.quiz.questions[index].status == 0) {
                                          return Colors.black; // Default color before selection
                                        }
                                        return answer.isCorrect
                                            ? Colors.green
                                            : (answer == state.quiz.questions[index].selectedAnswer
                                            ? Colors.pink
                                            : Colors.black);
                                      },
                                    ),
                                    groupValue: state.quiz.questions[index].selectedAnswer,
                                    onChanged: (value) {
                                      context.read<QuizBloc>().add(SelectAnswerEvent(value!, index));
                                    },
                                  ),
                                  const SizedBox(width: 8,),
                                  Expanded(
                                    child: Text(answer.text, style: kAnswerText),
                                  ),
                                ],
                              ),

                            ),
                          ),

                        if (state.quiz.questions[index].status != 0)
                          ExplainWidget(explain: state.quiz.questions[index].explain),
                      ],
                    ),
                  ),
                ),

                if (state.quiz.questions[index].status == 0 && state.quiz.questions[index].selectedAnswer != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<QuizBloc>().add(const CheckAnswerEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                           Icon(
                            Icons.check,
                            size: 24,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 8),
                          Text('Kiểm tra'.toUpperCase(), style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,

                          ),),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  color: secondColor.withValues(alpha: 0.7),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => context.read<QuizBloc>().add(const DecreaseQuestionIndexEvent()),
                          icon: const Icon(FontAwesomeIcons.anglesLeft)),
                      IconButton(
                        onPressed: () {
                          showMaterialModalBottomSheet(
                            context: context,
                            expand: false,
                            builder: (ctx) => Material(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                height: 400,
                                color: Colors.white,
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: state.quiz.questions.length,
                                  itemBuilder: (ctx, index) {
                                    QuestionModel question = state.quiz.questions[index];
                                    return InkWell(
                                      onTap: () {
                                        context.read<QuizBloc>().add(GoToQuestionEvent(index));
                                        ctx.pop();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: question.status == 2
                                              ? Colors.red
                                              : question.status == 1
                                              ? Colors.green
                                              : Colors.blue.shade50,
                                        ),
                                        child: Center(child: Text('${question.index}')),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          FontAwesomeIcons.listUl,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () => context.read<QuizBloc>().add(const IncreaseQuestionIndexEvent()),
                          icon: const Icon(FontAwesomeIcons.anglesRight)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
            // bottomSheet: Padding(
            //   padding:  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            //   child: const AnchoredAdaptiveExample(),
            // ),
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

