

import 'package:gplx_app/core/utils/typedefs.dart';

import '../entities/sign_entity.dart';

abstract class SignRepo {
  const SignRepo();

  ResultFuture<List<SignEntity>> getSigns();


}