




import 'package:dartz/dartz.dart';
import 'package:gplx_app/core/common/features/data/datasources/chapter_remote_data_src.dart';
import 'package:gplx_app/core/common/features/domain/entities/chapter_entity.dart';
import 'package:gplx_app/core/common/features/domain/entities/question_entity.dart';
import 'package:gplx_app/core/common/features/domain/repos/chapter_repo.dart';
import 'package:gplx_app/core/common/features/domain/repos/question_repo.dart';

import '../../../../errors/exceptions.dart';
import '../../../../errors/failures.dart';
import '../../../../utils/typedefs.dart';

class ChapterRepoImpl implements ChapterRepo {
  const ChapterRepoImpl(this._remoteDataSrc);
  final ChapterRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<List<ChapterEntity>> getChapters() async {
    try {
      final chapters = await _remoteDataSrc.getChapters();
      return Right(chapters);
    } on ServerException catch(e){
      return Left(ServerFailure.fromException(e));
    }
  }

}