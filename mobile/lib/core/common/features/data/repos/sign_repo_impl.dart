import 'package:dartz/dartz.dart';
import 'package:gplx_app/core/common/features/domain/repos/sign_repo.dart';

import '../../../../errors/exceptions.dart';
import '../../../../errors/failures.dart';
import '../../../../utils/typedefs.dart';
import '../../domain/entities/sign_entity.dart';
import '../datasources/sign_remote_data_src.dart';

class SignRepoImpl implements SignRepo {
  const SignRepoImpl(this._remoteDataSrc);

  final SignRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<List<SignEntity>> getSigns() async {
    try {
      final signs = await _remoteDataSrc.getSigns();
      return Right(signs);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}