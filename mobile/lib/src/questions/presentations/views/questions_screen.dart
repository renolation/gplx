import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/common/features/data/models/answer_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/extenstions/context_extension.dart';
import 'package:gplx_app/core/utils/colors.dart';
import 'package:gplx_app/core/widgets/explain_widget.dart';
import 'package:hive_ce/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/ads/banner_ad.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/questions_bloc.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      builder: (context, state) {
        if (state is QuestionsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is QuestionsLoaded) {
          final index = state.index;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.animateTo(
              index * (80),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
          if (state.questions.isEmpty) {
            return const Center(child: Text('No questions available'));
          }
          return Scaffold(
            appBar: AppBar(
              title:  Text(state.questions[index].chapter?.name ?? 'Toàn bộ câu hỏi'),
              actions: [
                IconButton(
                    onPressed: () {
                      //note: reset all questions belong to chapter
                      // loop list, set status = 0, selectedAnswer = null
                    },
                    icon: const Icon(FontAwesomeIcons.arrowsRotate, color: thirdColor,))
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
                    itemCount: state.questions.length,
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    itemBuilder: (ctx, i) {
                      QuestionModel question = state.questions[i];
                      return InkWell(
                        onTap: () => context.read<QuestionsBloc>().add(GoToQuestionEvent(i)),
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
                          child: Center(child: Text('Câu ${state.questions[i].index}')),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Câu hỏi ${state.questions[index].index}: ${state.questions[index].text}',
                          style: kQuestionText),
                    ),
                    if (state.questions[index].image!.isNotEmpty)
                      Center(child: Image.network('https://taplaixe.vn${state.questions[index].image!}', width: context.width * 0.8,)),
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Divider(),
                    ),
                    for (final answer in state.questions[index].answers)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: InkWell(
                          onTap: () {
                            context.read<QuestionsBloc>().add(SelectAnswerEvent(answer, index));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio<AnswerModel>(
                                value: answer,
                                fillColor: WidgetStateProperty.resolveWith<Color>(
                                      (states) {
                                    if (state.questions[index].status == 0) {
                                      return Colors.black; // Default color before selection
                                    }
                                    return answer.isCorrect
                                        ? Colors.green
                                        : (answer == state.questions[index].selectedAnswer
                                        ? Colors.pink
                                        : Colors.black);
                                  },
                                ),
                                groupValue: state.questions[index].selectedAnswer,
                                onChanged: (value) {
                                  context.read<QuestionsBloc>().add(SelectAnswerEvent(value!, index));
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

                    if (state.questions[index].status != 0)
                      ExplainWidget(explain: state.questions[index].explain),
                  ],
                )),


                if (state.questions[index].status == 0 && state.questions[index].selectedAnswer != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<QuestionsBloc>().add(const CheckAnswerEvent());
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
                          onPressed: () => context.read<QuestionsBloc>().add(const DecreaseQuestionIndexEvent()),
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
                                  itemCount: state.questions.length,
                                  itemBuilder: (ctx, index) {
                                    QuestionModel question = state.questions[index];
                                    return InkWell(
                                      onTap: () {
                                        context.read<QuestionsBloc>().add(GoToQuestionEvent(index));
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
                          onPressed: () => context.read<QuestionsBloc>().add(const IncreaseQuestionIndexEvent()),
                          icon: const Icon(FontAwesomeIcons.anglesRight)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          );
        } else if (state is QuestionsError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No questions available'));
        }
      },
    );
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
                          onTap: () => context.read<QuestionsBloc>().add(GoToQuestionEvent(i)),
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
      // bottomSheet: Padding(
      //   padding:  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      //   child: const AnchoredAdaptiveExample(),
      // ),
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
