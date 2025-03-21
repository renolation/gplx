import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/common/features/data/models/answer_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/ads/banner_ad.dart';
import '../bloc/questions_bloc.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is QuestionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionsLoaded) {
            final index = state.index;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController.animateTo(
                index * (40 + 8 * 2),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
            if (state.questions.isEmpty) {
              return const Center(child: Text('No questions available'));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: state.questions.length,
                      scrollDirection: Axis.horizontal,
                      controller: scrollController,
                      itemBuilder: (ctx, i) {
                        return InkWell(
                          onTap:() => context.read<QuestionsBloc>().add(GoToQuestionEvent(i)),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            height: 40,
                            color: i == index ? Colors.red : Colors.blue,
                            child: Center(child: Text('Câu ${state.questions[i].index}')),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuestionsBloc>().add(const DecreaseQuestionIndexEvent());
                    },
                    child: Text('Previous'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuestionsBloc>().add(const IncreaseQuestionIndexEvent());
                    },
                    child: Text('Next'),
                  ),
                  Text('Câu: ${state.questions[index].index}'),
                  Text('${state.questions[index].text}'),
                  Container(
                    child: Column(
                      children: [
                        for (final answer in state.questions[index].answers!)
                          ListTile(
                            title: Text(' ${answer.isCorrect} ${answer.text}'),
                            leading: Radio<AnswerModel>(
                              value: answer,
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                (states) {
                                  if (state.questions[index].status == 0) {
                                    return Colors.black; // Default color before selection
                                  }
                                  return answer.isCorrect
                                      ? Colors.green
                                      : (answer == state.questions[index].selectedAnswer ? Colors.red : Colors.black);
                                },
                              ),
                              groupValue: state.questions[index].selectedAnswer,
                              onChanged: (value) {
                                context.read<QuestionsBloc>().add(SelectAnswerEvent(value!, index));
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<QuestionsBloc>().add(const CheckAnswerEvent());
                    },
                    child: Text('Check answer'),
                  ),
                  state.questions[index].status == 0 ? const SizedBox() : Text(state.questions[index].explain),
                ],
              ),
            );
          } else if (state is QuestionsError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No questions available'));
          }
        },
      ),
      bottomSheet: Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: const AnchoredAdaptiveExample(),
      ),
      // bottomSheet: BlocSelector<QuestionsBloc, QuestionsState, List<QuestionModel>>(selector: (state) {
      //   if (state is QuestionsLoaded) {
      //
      //    return state.questions;
      //   }
      //   return [];
      // }, builder: (context, state) {
      //   return Container(
      //     color: Colors.blue,
      //     padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 10),
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: TextButton(
      //             onPressed: () {},
      //             child: Text(state.length.toString()),
      //           ),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             showMaterialModalBottomSheet(
      //               context: context,
      //               expand: false,
      //               builder: (ctx) => Material(
      //                 clipBehavior: Clip.antiAlias,
      //                 child: Container(
      //                   height: 400,
      //                   color: Colors.white,
      //                   child: GridView.builder(
      //                     padding: EdgeInsets.zero,
      //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                       crossAxisCount: 6,
      //                       childAspectRatio: 1,
      //                     ),
      //                     itemCount: state.length,
      //                     itemBuilder: (ctx, index) {
      //                       return InkWell(
      //                         onTap: () {
      //                           context.read<QuestionsBloc>().add(GoToQuestionEvent(index));
      //                           ctx.pop();
      //                         },
      //                         child: Container(
      //                           margin: const EdgeInsets.all(4),
      //                           decoration: const BoxDecoration(
      //                             color: Colors.blue,
      //                           ),
      //                           child: Center(child: Text('${state[index].index}')),
      //                         ),
      //                       );
      //                     },
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //           child: const Text('Button'),
      //         ),
      //         Expanded(
      //           child: TextButton(
      //             onPressed: () {},
      //             child: Text('Finish'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   );
      // }),
    );
  }
}
