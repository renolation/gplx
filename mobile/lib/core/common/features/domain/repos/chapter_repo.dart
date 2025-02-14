import 'package:gplx_app/core/common/features/domain/entities/chapter_entity.dart';

import '../../../../utils/typedefs.dart';

abstract class ChapterRepo {
  const ChapterRepo();

  ResultFuture<List<ChapterEntity>> getChapters();

}