


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gplx_app/src/chapters/presentations/bloc/chapters_bloc.dart';

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
                return ListTile(
                  title: Text(chapter.name),
                  subtitle: Text(chapter.questions.length.toString()),
                );
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
