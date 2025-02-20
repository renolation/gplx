import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:hive_ce_flutter/adapters.dart';

class TheoryScreen extends StatelessWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.question_answer),
            onPressed: () {
              context.pushNamed('quiz');

            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ValueListenableBuilder(valueListenable: SettingsBox().box.listenable(), builder: (context, box, _){
            return TextButton(onPressed: (){
              SettingsBox().hasFinishedOnboarding = !SettingsBox().hasFinishedOnboarding;
            }, child: Text('Settings ${SettingsBox().hasFinishedOnboarding}'));
          }),
          ValueListenableBuilder(valueListenable: QuestionsBox().box.listenable(), builder: (context, box, _){
            return TextButton(onPressed: (){
            }, child: Text('Question ${QuestionsBox().question.text}'));
          }),
          IconButton(
            icon: const Icon(Icons.wheelchair_pickup),
            onPressed: () {
              context.pushNamed('chapters');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {
              context.pushNamed('quizzes');
            },
          ),
        ],
      ),
    );
  }
}
