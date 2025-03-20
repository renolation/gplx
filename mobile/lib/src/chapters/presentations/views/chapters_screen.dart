


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            return ListView.builder(
              itemCount: state.chapters.length,
              itemBuilder: (context, index) {
                final chapter = state.chapters[index];
                final Widget item = ListTile(
                  title: Text('Chuong ${chapter.index} ${chapter.name}'),
                  subtitle: Text(chapter.questions.length.toString()),
                  trailing:  Icon(Icons.add, color: chapter.isImportant ? Colors.red : Colors.blue,),
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
