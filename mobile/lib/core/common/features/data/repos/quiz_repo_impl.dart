
import 'package:dartz/dartz.dart';
import 'package:gplx_app/core/common/features/data/datasources/quiz_remote_data_src.dart';
import 'package:gplx_app/core/common/features/domain/entities/quiz_entity.dart';
import 'package:gplx_app/core/common/features/domain/repos/quiz_repo.dart';
import 'package:gplx_app/core/utils/typedefs.dart';

import '../../../../errors/exceptions.dart';
import '../../../../errors/failures.dart';

class QuizRepoImpl implements QuizRepo {

  const QuizRepoImpl(this._remoteDataSrc);

  final QuizRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<List<QuizEntity>> getQuizzes() async {
    try {
      final quizzes = await _remoteDataSrc.getQuizzes();
      return Right(quizzes);
    } on ServerException catch(e){
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<QuizEntity> getQuizById(int quizId) async {
    try {
      final quiz = await _remoteDataSrc.getQuizById(quizId);
      return Right(quiz);
    } on ServerException catch(e){
      return Left(ServerFailure.fromException(e));
    }
  }

}