import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_quizzes.dart';

import '../../../../core/common/features/data/models/answer_model.dart';
import '../../../../core/common/features/data/models/quiz_model.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc({required GetQuizById getQuizById})
      : _getQuizById = getQuizById,
        super(QuizInitial()) {
    on<GetQuizByIdEvent>(_getQuizByIdHandler);


    on<IncreaseQuestionIndexEvent>(_increaseQuestionIndexHandler);
    on<DecreaseQuestionIndexEvent>(_decreaseQuestionIndexHandler);
    // on<GoToQuestionEvent>(_goToQuestionHandler);
    // on<SelectAnswerEvent>(_selectAnswerHandler);
    // on<CheckAnswerEvent>(_checkAnswerHandler);


  }

  final GetQuizById _getQuizById;

  Future<void> _getQuizByIdHandler(
      GetQuizByIdEvent event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    print('event.id: ${event.id}');
    final quiz = await _getQuizById(event.id);
    quiz.fold(
      (failure) => emit(QuizError(failure.message)),
      (quiz) => emit(QuizLoaded(quiz as QuizModel)),
    );
  }

  void _increaseQuestionIndexHandler(IncreaseQuestionIndexEvent event, Emitter<QuizState> emit) {
    if((state as QuizLoaded).index == (state as QuizLoaded).quiz.questions.length - 1) return;
    emit((state as QuizLoaded).copyWith(index: (state as QuizLoaded).index + 1));
  }

  void _decreaseQuestionIndexHandler(DecreaseQuestionIndexEvent event, Emitter<QuizState> emit) {
    if((state as QuizLoaded).index == 0) return;
    emit((state as QuizLoaded).copyWith(index: (state as QuizLoaded).index + -1));
  }

}
