part of 'quiz_bloc.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];

}

final class QuizInitial extends QuizState {

}


final class QuizLoading extends QuizState {

}

final class QuizLoaded extends QuizState {
  final QuizModel quiz;
  final int index;

  const QuizLoaded(this.quiz,{this.index = 0});


  QuizLoaded copyWith({QuizModel? quiz, int? index}) {
    return QuizLoaded(
      quiz ?? this.quiz,
      index: index ?? this.index,
    );
  }


  @override
  List<Object> get props => [quiz,index];
}

final class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object> get props => [message];
}