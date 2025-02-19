

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state){
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizLoaded) {
            return Text(state.quiz.name);
          } else if (state is QuizError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No quizzes available'));
          }
        },
      ),
    );
  }
}
