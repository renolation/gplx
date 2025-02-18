import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/data/boxes.dart';
import 'core/services/injection_container.dart';
import 'core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bmkeuakzujzaerolpyga.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJta2V1YWt6dWp6YWVyb2xweWdhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc3MTcyNjIsImV4cCI6MjA1MzI5MzI2Mn0.SNawrx1J4iXqbWG7th2AYfC6vMMqldEIggr1iI5fJ-Y',
  );
  await initBoxes();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
