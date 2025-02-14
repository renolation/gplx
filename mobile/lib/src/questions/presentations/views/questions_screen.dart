import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/questions_bloc.dart';


class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          if (state is QuestionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionsLoaded) {
            return ListView.builder(
              itemCount: state.questions.length,
              itemBuilder: (context, index) {
                final question = state.questions[index];
                return ListTile(
                  title: Text(question.text),
                  subtitle: Text(question.explain!),
                );
              },
            );
          } else if (state is QuestionsError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No questions available'));
          }
        },
      ),
    );
  }
}