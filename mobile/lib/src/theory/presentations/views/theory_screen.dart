import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              context.goNamed('questions');
            },
          ),
        ],
      ),
      body: const Text('theory'),
    );
  }
}
