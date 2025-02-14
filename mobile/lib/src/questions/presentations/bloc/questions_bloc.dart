import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_questions.dart';

import '../../../../core/common/features/data/models/question_model.dart';
import 'package:equatable/equatable.dart';

part 'questions_state.dart';
part 'questions_event.dart';

class QuestionsBloc extends Bloc<QuestionsEvent ,QuestionsState> {
  QuestionsBloc({
    required GetQuestions getQuestions,
}) :
      _getQuestions = getQuestions,
        super(QuestionsInitial()){
    on<GetQuestionsEvent>(_getQuestionsHandler);
  }

  final GetQuestions _getQuestions;

  Future<void> _getQuestionsHandler(GetQuestionsEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    final questions = await _getQuestions();
    questions.fold(
          (failure) => emit(QuestionsError(failure.message)),
          (questions) => emit(QuestionsLoaded(questions as List<QuestionModel>)),
    );
  }

}
