


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/common/features/data/models/chapter_model.dart';
import 'package:gplx_app/core/common/features/data/models/question_model.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/utils/enums.dart';
import 'package:gplx_app/src/chapters/presentations/bloc/chapters_bloc.dart';

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
        builder: (context, state){
          if (state is ChaptersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChaptersLoaded) {
            List<ChapterModel> chapters = state.chapters.where((e) => e.vehicle == SettingsBox().vehicleTypeQuestion.convertToVehicle()).toList();
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                state.chapters[index].questions.sort((a, b) => a.index.compareTo(b.index));
                final chapter = chapters[index];
                QuestionModel firstQuestion = chapter.questions.first;
                QuestionModel lastQuestion = chapter.questions.last;
                int importantQuestionsCount = chapter.questions.where((element) => element.isImportant).length;

                final Widget item = ListTile(
                  title: Text('${chapter.name.split('về ').last.toUpperCase()}', style: TextStyle(color: chapter.isImportant ? Colors.red : Colors.black),),
                  subtitle: Text('${chapter.questions.length} câu: Từ câu ${firstQuestion.index}'
                      ' đến câu ${lastQuestion.index}${importantQuestionsCount > 0 ? ', có $importantQuestionsCount câu điểm liệt' :'.'}'),
                  onTap: () {
                    context.pushNamed('questions', pathParameters: {'chapterId': '${chapter.id}'});
                  },
                );
                if(index == 3) {
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
