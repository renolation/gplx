import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/data/models/quiz_model.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_questions.dart';
import 'package:gplx_app/core/data/boxes.dart';
import 'package:gplx_app/core/utils/enums.dart';

import '../../../../core/common/features/data/models/answer_model.dart';
import '../../../../core/common/features/data/models/question_model.dart';
import 'package:equatable/equatable.dart';

part 'questions_state.dart';

part 'questions_event.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc({
    required GetQuestions getQuestions,
    required GetQuestionByChapterId getQuestionByChapterId,
    required GetWrongAnswers getWrongAnswers,
    required GetImportantQuestions getImportantQuestions,
  })  : _getQuestions = getQuestions,
        _getQuestionByChapterId = getQuestionByChapterId,
        _getWrongAnswers = getWrongAnswers,
        _getImportantQuestions = getImportantQuestions,
        super(QuestionsInitial()) {
    on<GetQuestionsEvent>(_getQuestionsHandler);
    on<GetQuestionsByChapterIdEvent>(_getQuestionByChapterIdHandler);
    on<GetWrongAnswersEvent>(_getWrongAnswersHandler);
    on<GetImportantQuestionsEvent>(_getImportantQuestionsHandler);

    on<IncreaseQuestionIndexEvent>(_increaseQuestionIndexHandler);
    on<DecreaseQuestionIndexEvent>(_decreaseQuestionIndexHandler);
    on<GoToQuestionEvent>(_goToQuestionHandler);
    on<SelectAnswerEvent>(_selectAnswerHandler);
    on<CheckAnswerEvent>(_checkAnswerHandler);
  }

  final GetQuestions _getQuestions;
  final GetQuestionByChapterId _getQuestionByChapterId;
  final GetWrongAnswers _getWrongAnswers;
  final GetImportantQuestions _getImportantQuestions;


  Future<void> _getQuestionsHandler(
      GetQuestionsEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    final questions = await _getQuestions();
    questions.fold(
      (failure) => emit(QuestionsError(failure.message)),
      (questions) => emit(QuestionsLoaded(questions as List<QuestionModel>)),
    );
  }

  Future<void> _getQuestionByChapterIdHandler(
      GetQuestionsByChapterIdEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    final questions = await _getQuestionByChapterId(event.chapterId);
    questions.fold(
      (failure) => emit(QuestionsError(failure.message)),
      (questions) => emit(QuestionsLoaded(questions as List<QuestionModel>)),
    );
  }

  Future<void> _getWrongAnswersHandler(
      GetWrongAnswersEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    final questions = await _getWrongAnswers();
    questions.fold(
      (failure) => emit(
        QuestionsError(failure.message),
      ),
      (questions) => emit(
        QuestionsLoaded(
          (questions as List<QuestionModel>)
          ,
        ),
      ),
    );
  }

  Future<void> _getImportantQuestionsHandler(
      GetImportantQuestionsEvent event, Emitter<QuestionsState> emit) async {
    emit(QuestionsLoading());
    final questions = await _getImportantQuestions();
    questions.fold(
      (failure) => emit(
        QuestionsError(failure.message),
      ),
      (questions) => emit(
        QuestionsLoaded(
          (questions as List<QuestionModel>)
          ,
        ),
      ),
    );
  }

  void _increaseQuestionIndexHandler(
      IncreaseQuestionIndexEvent event, Emitter<QuestionsState> emit) {
    if ((state as QuestionsLoaded).index ==
        (state as QuestionsLoaded).questions.length - 1) return;
    emit((state as QuestionsLoaded)
        .copyWith(index: (state as QuestionsLoaded).index + 1));
  }

  void _decreaseQuestionIndexHandler(
      DecreaseQuestionIndexEvent event, Emitter<QuestionsState> emit) {
    if ((state as QuestionsLoaded).index == 0) return;
    emit((state as QuestionsLoaded)
        .copyWith(index: (state as QuestionsLoaded).index + -1));
  }

  void _goToQuestionHandler(
      GoToQuestionEvent event, Emitter<QuestionsState> emit) {
    emit((state as QuestionsLoaded).copyWith(index: event.index));
  }

  void _selectAnswerHandler(
      SelectAnswerEvent event, Emitter<QuestionsState> emit) {
    final updatedQuestions =
        List<QuestionModel>.from((state as QuestionsLoaded).questions);
    updatedQuestions[event.index] =
        updatedQuestions[event.index].copyWith(selectedAnswer: event.answer);

    emit((state as QuestionsLoaded).copyWith(questions: updatedQuestions));
  }

  void _checkAnswerHandler(
      CheckAnswerEvent event, Emitter<QuestionsState> emit) {
    final updatedQuestions =
        List<QuestionModel>.from((state as QuestionsLoaded).questions);
    QuestionModel currentQuestion =
        updatedQuestions[(state as QuestionsLoaded).index];
    AnswerModel correctAnswer = currentQuestion.answers
        .firstWhere((element) => element.isCorrect == true);
    if (currentQuestion.selectedAnswer == correctAnswer) {
      updatedQuestions[(state as QuestionsLoaded).index] =
          currentQuestion.copyWith(isCorrect: true, status: 1);
    } else {
      updatedQuestions[(state as QuestionsLoaded).index] =
          currentQuestion.copyWith(isCorrect: false, status: 2);
    }

    // QuestionsBox().question = updatedQuestions[(state as QuestionsLoaded).index];
    // QuestionsBox().saveAnsweredQuestion(updatedQuestions[(state as QuestionsLoaded).index]);
    var list = [...QuestionsBox().wrongQuestions];
    list.removeWhere((element) =>
        element.id == updatedQuestions[(state as QuestionsLoaded).index].id);
    list.add(updatedQuestions[(state as QuestionsLoaded).index]);
    QuestionsBox().wrongQuestions = list;
    emit((state as QuestionsLoaded).copyWith(questions: updatedQuestions));
  }
}
