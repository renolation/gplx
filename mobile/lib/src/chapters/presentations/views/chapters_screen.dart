import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/common/features/data/models/chapter_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/utils/colors.dart';
import 'package:gplx_app/core/utils/enums.dart';
import 'package:gplx_app/src/chapters/presentations/bloc/chapters_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../../../../core/ads/inline_adaptive_ad.dart';

class ChaptersScreen extends StatelessWidget {
  const ChaptersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapters'),
      ),
      body: BlocBuilder<ChaptersBloc, ChaptersState>(
        builder: (context, state) {
          if (state is ChaptersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChaptersLoaded) {
            List<ChapterModel> chapters =
                state.chapters.where((e) => e.vehicle == SettingsBox().vehicleTypeQuestion.convertToVehicle()).toList();
            chapters.sort((a, b) => a.index.compareTo(b.index));
            return ValueListenableBuilder(
                valueListenable: QuestionsBox().box.listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      state.chapters[index].questions.sort((a, b) => a.index.compareTo(b.index));
                      final chapter = chapters[index];
                      QuestionModel firstQuestion = chapter.questions.first;
                      QuestionModel lastQuestion = chapter.questions.last;
                      int importantQuestionsCount = chapter.questions.where((element) => element.isImportant).length;

                      int countAnswered =
                          QuestionsBox().getChapterById(chapter.id)!.questions.where((q) => q.status > 0).length;

                      final Widget item = InkWell(
                        onTap: () {
                          context.pushNamed('questions', pathParameters: {'chapterId': '${chapter.id}'});
                        },
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Text('${chapter.id}'),
                              AutoSizeText(
                                chapter.name.split('về ').last.toUpperCase(),
                                minFontSize: 12,
                                maxFontSize: 20,
                                style: TextStyle(color: chapter.isImportant ? Colors.red : Colors.black, fontSize: 18),
                              ),
                              Text('${chapter.questions.length} câu: Từ câu ${firstQuestion.index}'
                                  ' đến câu ${lastQuestion.index}${importantQuestionsCount > 0 ? ', có $importantQuestionsCount câu điểm liệt' : '.'}'),
                              // const Spacer(),
                              Builder(builder: (context) {
                                int questionsCount = chapter.questions.length;
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                        width: double.infinity,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text('$countAnswered/$questionsCount'),
                                  ],
                                );
                              })
                            ],
                          ),
                        ),
                      );

                      if (index == 3) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const InlineAdaptiveExample(),
                            item
                          ],
                        );
                      }
                      return item;
                    },
                  );
                });
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                state.chapters[index].questions.sort((a, b) => a.index.compareTo(b.index));
                final chapter = chapters[index];
                QuestionModel firstQuestion = chapter.questions.first;
                QuestionModel lastQuestion = chapter.questions.last;
                int importantQuestionsCount = chapter.questions.where((element) => element.isImportant).length;

                final Widget item = InkWell(
                  onTap: () {
                    context.pushNamed('questions', pathParameters: {'chapterId': '${chapter.id}'});
                  },
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AutoSizeText(
                          chapter.name.split('về ').last.toUpperCase(),
                          minFontSize: 12,
                          maxFontSize: 20,
                          style: TextStyle(color: chapter.isImportant ? Colors.red : Colors.black, fontSize: 18),
                        ),
                        Text('${chapter.questions.length} câu: Từ câu ${firstQuestion.index}'
                            ' đến câu ${lastQuestion.index}${importantQuestionsCount > 0 ? ', có $importantQuestionsCount câu điểm liệt' : '.'}'),
                        // const Spacer(),
                        Builder(builder: (context) {
                          int countAnswered = chapter.questions.where((element) => element.status > 0).length;
                          int questionsCount = chapter.questions.length;
                          return Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 3,
                                  width: double.infinity,
                                  color: Colors.blue,
                                ),
                              ),
                              Text('$countAnswered/$questionsCount'),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                );

                if (index == 3) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // const InlineAdaptiveExample(),
                      item
                    ],
                  );
                }
                return item;
              },
            );
          } else if (state is ChaptersError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No chapters available'));
          }
        },
      ),
    );
  }
}
