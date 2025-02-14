import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_questions.dart';

import '../../../../core/common/features/data/models/question_model.dart';
import 'package:equatable/equatable.dart';

part 'questions_state.dart';
part 'questions_event.dart';

class QuestionsBloc extends Bloc<QuestionsEvent ,QuestionsState> {
  QuestionsBloc({
    required GetQuestionByChapterId getQuestionByChapterId,
}) :
        _getQuestionByChapterId = getQuestionByChapterId,
        super(QuestionsInitial()){
    on<GetQuestionsByChapterIdEvent>(_getQuestionByChapterIdHandler);
  }

  final GetQuestionByChapterId _getQuestionByChapterId;

  Future<void> _getQuestionByChapterIdHandler(GetQuestionsByChapterIdEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    final questions = await _getQuestionByChapterId(event.chapterId);
    questions.fold(
          (failure) => emit(QuestionsError(failure.message)),
          (questions) => emit(QuestionsLoaded(questions as List<QuestionModel>)),
    );
  }

}
