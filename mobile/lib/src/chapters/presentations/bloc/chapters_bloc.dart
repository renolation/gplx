import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gplx_app/core/common/features/domain/usecases/get_chapters.dart';
import 'package:meta/meta.dart';

import '../../../../core/common/features/data/models/chapter_model.dart';

part 'chapters_event.dart';
part 'chapters_state.dart';

class ChaptersBloc extends Bloc<ChaptersEvent, ChaptersState> {
  ChaptersBloc({
    required GetChapters getChapters,
}) :
        _getChapters = getChapters,
        super(ChaptersInitial()) {
    on<GetChaptersEvent>(_getChaptersHandler);
  }

  final GetChapters _getChapters;

  Future<void> _getChaptersHandler(GetChaptersEvent event, Emitter<ChaptersState> emit) async {
    emit(ChaptersLoading());
    final chapters = await _getChapters();
    chapters.fold(
          (failure) => emit(ChaptersError(failure.message)),
          (chapters) => emit(ChaptersLoaded(chapters as List<ChapterModel>)),
    );
  }
}
