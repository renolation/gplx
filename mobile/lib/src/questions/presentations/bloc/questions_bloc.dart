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
    on<IncreaseQuestionIndexEvent>(_increaseQuestionIndexHandler);
    on<DecreaseQuestionIndexEvent>(_decreaseQuestionIndexHandler);
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

  void _increaseQuestionIndexHandler(IncreaseQuestionIndexEvent event, Emitter<QuestionsState> emit) {
    if((state as QuestionsLoaded).index == (state as QuestionsLoaded).questions.length - 1) return;
    emit((state as QuestionsLoaded).copyWith(index: (state as QuestionsLoaded).index + 1));
  }
  void _decreaseQuestionIndexHandler(DecreaseQuestionIndexEvent event, Emitter<QuestionsState> emit) {
    if((state as QuestionsLoaded).index == 0) return;
    emit((state as QuestionsLoaded).copyWith(index: (state as QuestionsLoaded).index + -1));
  }
}
