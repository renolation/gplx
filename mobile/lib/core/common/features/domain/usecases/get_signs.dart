
import 'package:gplx_app/core/usecase/usecase.dart';

import '../../../../utils/typedefs.dart';
import '../entities/sign_entity.dart';
import '../repos/sign_repo.dart';

class GetSigns extends UseCaseWithoutParams<List<SignEntity>> {
  const GetSigns(this._repo);

  final SignRepo _repo;

  @override
  ResultFuture<List<SignEntity>> call() async => _repo.getSigns();
}