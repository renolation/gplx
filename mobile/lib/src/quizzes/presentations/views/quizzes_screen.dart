import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/src/quizzes/presentations/bloc/quizzes_bloc.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
      ),
      body: BlocBuilder<QuizzesBloc, QuizzesState>(
        builder: (context, state) {
          if (state is QuizzesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizzesLoaded) {
            return ListView.builder(
              itemCount: state.quizzes.length,
              itemBuilder: (context, index) {
                final quiz = state.quizzes[index];
                return GestureDetector(
                    onTap: () {
                      print('aa');
                      context.pushNamed('quiz', pathParameters: {'quizId': '${quiz.id}'});

                    },
                    child: Text(quiz.name));
              },
            );
          } else if (state is QuizzesError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No quizzes available'));
          }
        },
      ),
    );
  }
}
