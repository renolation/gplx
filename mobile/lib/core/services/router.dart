import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gplx_app/src/chapters/presentations/bloc/chapters_bloc.dart';
import 'package:gplx_app/src/chapters/presentations/views/chapters_screen.dart';
import 'package:gplx_app/src/questions/presentations/views/questions_screen.dart';

import '../../src/home/presentations/views/home_screen.dart';
import '../../src/questions/presentations/bloc/questions_bloc.dart';
import '../../src/theory/presentations/views/theory_screen.dart';
import 'injection_container.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'homeNav');

final GoRouter goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/theory',
  routes: <RouteBase>[

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      // routes: <RouteBase>[
      //   GoRoute(
      //     path: 'details',
      //     builder: (BuildContext context, GoRouterState state) => const DetailsScreen(label: 'A'),
      //   ),
      // ],
    ),

    GoRoute(
      name: 'theory',
      path: '/theory',
      builder: (BuildContext context, GoRouterState state) => const TheoryScreen(),
      routes: <RouteBase>[
        GoRoute(
          name: 'chapters',
          path: 'chapters',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => ChaptersBloc(
                getChapters: sl(),
              )..add(const GetChaptersEvent()),
              child: const ChaptersScreen(),
            );
          },
        ),
      ],
    ),


    GoRoute(
      name: 'questions',
      path: '/questions/:chapterId',
      builder: (BuildContext context, GoRouterState state) {
        int chapterId =  int.parse(state.pathParameters['chapterId']!);
        return BlocProvider(
          create: (context) => QuestionsBloc(
            // getQuestions: sl(),
            getQuestionByChapterId: sl(),
          )..add(GetQuestionsByChapterIdEvent(chapterId)),
          child: const QuestionsScreen(),
        );
      },
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => navigationShell.goBranch(index),
      ),
    );
  }
}
