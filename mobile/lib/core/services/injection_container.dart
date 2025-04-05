import 'package:get_it/get_it.dart';
import 'package:gplx_app/core/common/features/data/datasources/quiz_remote_data_src.dart';
import 'package:gplx_app/core/common/features/data/datasources/sign_remote_data_src.dart';
import 'package:gplx_app/core/common/features/data/repos/quiz_repo_impl.dart';
import 'package:gplx_app/core/common/features/domain/repos/question_repo.dart';
import 'package:gplx_app/core/common/features/domain/repos/quiz_repo.dart';
import 'package:gplx_app/core/common/features/domain/repos/sign_repo.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_quizzes.dart';
import 'package:gplx_app/src/quizzes/presentations/bloc/quizzes_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../src/chapters/presentations/bloc/chapters_bloc.dart';
import '../../src/questions/presentations/bloc/questions_bloc.dart';
import '../../src/quiz/presentations/bloc/counter_cubit.dart';
import '../../src/quiz/presentations/bloc/quiz_bloc.dart';
import '../../src/sign/presentations/bloc/sign_bloc.dart';
import '../common/features/data/datasources/chapter_remote_data_src.dart';
import '../common/features/data/datasources/question_remote_data_src.dart';
import '../common/features/data/repos/chapter_repo_impl.dart';
import '../common/features/data/repos/question_repo_impl.dart';
import '../common/features/data/repos/sign_repo_impl.dart';
import '../common/features/domain/repos/chapter_repo.dart';
import '../common/features/domain/usecases/get_chapters.dart';
import '../common/features/domain/usecases/get_questions.dart';
import '../common/features/domain/usecases/get_signs.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initQuestions();
  await _initChapters();
  await _initQuizzes();
  await _initSigns();
}

Future<void> _initQuestions() async {
  sl
  //bloc
    ..registerFactory(
      () => QuestionsBloc(
        getQuestions: sl(),
        getImportantQuestions: sl(),
        getQuestionByChapterId: sl(),
        getWrongAnswers: sl(),
      ),
    )
    //use case
    ..registerLazySingleton(() => GetQuestions(sl()))
    ..registerLazySingleton(() => GetWrongAnswers(sl()))
    ..registerLazySingleton(() => GetQuestionByChapterId(sl()))
    ..registerLazySingleton(() => GetImportantQuestions(sl()))
    //repo
    ..registerLazySingleton<QuestionRepo>(() => QuestionRepoImpl(sl()))
    //data src
    ..registerLazySingleton<QuestionRemoteDataSrc>(
      () => QuestionRemoteDataSrcImpl(client: sl()),
    )
    ..registerLazySingleton(() => Supabase.instance.client);
}

Future<void> _initChapters() async {
  sl
    ..registerFactory(
      () => ChaptersBloc(
        getChapters: sl(),
      ),
    )
    ..registerLazySingleton(() => GetChapters(sl()))
    ..registerLazySingleton<ChapterRepo>(() => ChapterRepoImpl(sl()))
    ..registerLazySingleton<ChapterRemoteDataSrc>(
      () => ChapterRemoteDataSrcImpl(client: sl()),
    );
  // ..registerLazySingleton(() => Supabase.instance.client);
}

Future<void> _initQuizzes() async {
  sl
    ..registerFactory(
      () => QuizzesBloc(getQuizzes: sl()),
    )
    ..registerFactory(
      () => QuizBloc(
        getQuizById: sl(),
        getRandomQuiz: sl(),
      ),
    )

    ..registerLazySingleton(() => GetQuizzes(sl()))
    ..registerLazySingleton(() => GetQuizById(sl()))
    ..registerLazySingleton(() => GetRandomQuiz(sl()))
    ..registerLazySingleton<QuizRepo>(() => QuizRepoImpl(sl()))
    ..registerLazySingleton<QuizRemoteDataSrc>(
        () => QuizRemoteDataSrcImpl(client: sl()));
}

Future<void> _initSigns() async {
  sl
  ..registerFactory(
    () => SignBloc(
      getSigns: sl(),
    ),
  )
      ..registerLazySingleton(() => GetSigns(sl()))
      ..registerLazySingleton<SignRepo>(() => SignRepoImpl(sl()))
      ..registerLazySingleton<SignRemoteDataSrc>(
          () => SignRemoteDataSrcImpl(client: sl())
      );
}