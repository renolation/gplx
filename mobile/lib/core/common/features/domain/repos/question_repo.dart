

import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';

import '../../../../utils/typedefs.dart';

abstract class QuestionRepo {
  const QuestionRepo();

  ResultFuture<List<QuestionEntity>> getQuestions();

}