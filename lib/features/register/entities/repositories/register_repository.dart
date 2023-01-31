import 'package:dartz/dartz.dart';

import '../../../../base/base_failure.dart';
import '../../../checkin/entities/model/user_model.dart';

abstract class RegisterRepository {
  Future<Either<BaseFailure, UserModel>> register(UserModel user);
}
