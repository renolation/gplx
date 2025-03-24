

import 'package:dartz/dartz.dart';
import 'package:gplx_app/core/common/features/data/datasources/question_remote_data_src.dart';
import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';
import 'package:gplx_app/core/common/features/domain/repos/question_repo.dart';
import 'package:gplx_app/core/errors/exceptions.dart';
import 'package:gplx_app/core/utils/typedefs.dart';

import '../../../../errors/failures.dart';

class QuestionRepoImpl implements QuestionRepo {
  const QuestionRepoImpl(this._remoteDataSrc);

  final QuestionRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<List<QuestionEntity>> getQuestions() async {
    try {
      final questions = await _remoteDataSrc.getQuestions();
      return Right(questions);
    } on ServerException catch(e){
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<QuestionEntity>> getQuestionsByChapterId(int chapterId) async {
    try {
      final questions = await _remoteDataSrc.getQuestionsByChapterId(chapterId);
      return Right(questions);
    } on ServerException catch(e){
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<QuestionEntity>> getWrongAnswers() async {
   try {
     final questions = await _remoteDataSrc.getWrongAnswers();
     return Right(questions);
   } on ServerException catch(e){
     return Left(ServerFailure.fromException(e));
   }
  }

  @override
  ResultFuture<List<QuestionEntity>> getImportantQuestions() async {
    try {
      final questions = await _remoteDataSrc.getImportantQuestions();
      return Right(questions);
    } on ServerException catch(e){
      return Left(ServerFailure.fromException(e));
    }
  }
}