

import '../../../../usecase/usecase.dart';
import '../../../../utils/typedefs.dart';
import '../entities/chapter_entity.dart';
import '../repos/chapter_repo.dart';

class GetChapters extends UseCaseWithoutParams<List<ChapterEntity>> {
  const GetChapters(this._repo);

  final ChapterRepo _repo;

  @override
  ResultFuture<List<ChapterEntity>> call() async => _repo.getChapters();
}


