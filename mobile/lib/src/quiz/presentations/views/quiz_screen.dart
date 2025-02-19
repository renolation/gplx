import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz_bloc.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Scaffold(
            extendBodyBehindAppBar: true,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is QuizLoaded) {
          //note: body
          return Text(state.quiz.name);
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
