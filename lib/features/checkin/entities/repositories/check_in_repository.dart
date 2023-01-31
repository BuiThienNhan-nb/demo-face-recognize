import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../base/base_failure.dart';
import '../model/user_model.dart';

abstract class CheckInRepository {
  Future<Either<BaseFailure, bool>> checkIn(Float32List faceInfo);
  Future<Either<BaseFailure, List<UserModel>>> getAllUsersInfo();
}
