

import 'package:gplx_app/core/common/features/domain/entities/quiz_entity.dart';
import 'package:gplx_app/core/common/features/domain/repos/quiz_repo.dart';
import 'package:gplx_app/core/usecase/usecase.dart';

import '../../../../utils/typedefs.dart';

class GetQuizzes extends UseCaseWithoutParams<List<QuizEntity>> {

  GetQuizzes(this._repo);
  final QuizRepo _repo;

  @override
  ResultFuture<List<QuizEntity>> call() async => _repo.getQuizzes();
}

class GetQuizById extends UseCaseWithParams<QuizEntity, int> {
  GetQuizById(this._repo);
  final QuizRepo _repo;

  @override
  ResultFuture<QuizEntity> call(int params) async => _repo.getQuizById(params);
}