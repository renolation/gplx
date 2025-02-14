part of 'chapters_bloc.dart';

abstract class ChaptersState {

  const ChaptersState();

  @override
  List<Object> get props => [];

}

class ChaptersInitial extends ChaptersState {}

class ChaptersLoading extends ChaptersState {}

class ChaptersLoaded extends ChaptersState {
  final List<ChapterModel> chapters;

  const ChaptersLoaded(this.chapters);

  @override
  List<Object> get props => [chapters];
}

class ChaptersError extends ChaptersState {
  final String message;

  const ChaptersError(this.message);

  @override
  List<Object> get props => [message];
}