

import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';
import 'package:gplx_app/core/usecase/usecase.dart';

import '../../../../utils/typedefs.dart';
import '../repos/question_repo.dart';

class GetQuestions extends UseCaseWithoutParams<List<QuestionEntity>> {
  const GetQuestions(this._repo);

  final QuestionRepo _repo;

  @override
  ResultFuture<List<QuestionEntity>> call() async => _repo.getQuestions();
}

class GetQuestionByChapterId extends UseCaseWithParams<List<QuestionEntity>, int> {
  const GetQuestionByChapterId(this._repo);

  final QuestionRepo _repo;

  @override
  ResultFuture<List<QuestionEntity>> call(int params) async => _repo.getQuestionsByChapterId(params);
}

class GetWrongAnswers extends UseCaseWithoutParams<List<QuestionEntity>> {
  const GetWrongAnswers(this._repo);

  final QuestionRepo _repo;

  @override
  ResultFuture<List<QuestionEntity>> call() async => _repo.getWrongAnswers();
}

class GetImportantQuestions extends UseCaseWithoutParams<List<QuestionEntity>> {
  const GetImportantQuestions(this._repo);

  final QuestionRepo _repo;

  @override
  ResultFuture<List<QuestionEntity>> call() async => _repo.getImportantQuestions();
}