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
          ValueListenableBuilder(valueListenable: SettingsBox().box.listenable(), builder: (context, box, _){
            return TextButton(onPressed: (){
            }, child: Text('Type ${SettingsBox().vehicleTypeQuestion}'));
          }),
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
            }, child: Text('Question ${QuestionsBox().wrongQuestions.length}'));
          }),
          TextButton(
            child: Text('chapter'),
            onPressed: () {
              context.pushNamed('chapters');
            },
          ),
          TextButton(
            child: Text('wrong answers'),
            onPressed: () {
              context.pushNamed('wrongAnswers');
            },
          ),
          TextButton(
            child: Text('quizzes'),
            onPressed: () {
              context.pushNamed('quizzes');
            },
          ),
        ],
      ),
    );
  }
}
