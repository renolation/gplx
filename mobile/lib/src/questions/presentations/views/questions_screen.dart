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
            final index = state.index;
            return Column(
              children: [
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
                Text('index: $index ${state.questions[index].text}'),
              ],
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