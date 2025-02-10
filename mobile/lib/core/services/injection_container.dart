import 'package:get_it/get_it.dart';
import 'package:gplx_app/core/common/features/domain/repos/question_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../src/questions/presentations/bloc/questions_bloc.dart';
import '../common/features/data/datasources/question_remote_data_src.dart';
import '../common/features/data/repos/question_repo_impl.dart';
import '../common/features/domain/usecases/get_questions.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initQuestions();
}

Future<void> _initQuestions() async {
  sl
    ..registerFactory(
      () => QuestionsBloc(
        getQuestions: sl(),
      ),
    )
    ..registerLazySingleton(() => GetQuestions(sl()))
    ..registerLazySingleton<QuestionRepo>(() => QuestionRepoImpl(sl()))
    ..registerLazySingleton<QuestionRemoteDataSrc>(
      () => QuestionRemoteDataSrcImpl(client: sl()),
    )
    ..registerLazySingleton(() => Supabase.instance.client);
}
