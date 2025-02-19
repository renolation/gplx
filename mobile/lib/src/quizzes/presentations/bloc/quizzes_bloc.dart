import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_quizzes.dart';
import 'package:meta/meta.dart';

import '../../../../core/common/features/data/models/quiz_model.dart';

part 'quizzes_event.dart';

part 'quizzes_state.dart';

class QuizzesBloc extends Bloc<QuizzesEvent, QuizzesState> {
  QuizzesBloc({
    required GetQuizzes getQuizzes,
  })
      :
        _getQuizzes = getQuizzes,
        super(QuizzesInitial()) {
    on<GetQuizzesEvent>(_getQuizzesHandler);
  }


  final GetQuizzes _getQuizzes;

  Future<void> _getQuizzesHandler(GetQuizzesEvent event, Emitter<QuizzesState> emit) async {
    emit(QuizzesLoading());
    final quizzes =await _getQuizzes();
    quizzes.fold(
    (failure) => emit(QuizzesError(failure.message)),
    (quizzes) => emit(QuizzesLoaded(quizzes as List<QuizModel>)),
    );
  }
}
