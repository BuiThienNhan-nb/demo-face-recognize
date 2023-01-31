import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_failure.dart';
import '../../entities/model/user_model.dart';
import '../../entities/repositories/check_in_repository.dart';
import '../datasources/check_in_data_source.dart';

@LazySingleton(as: CheckInRepository)
class CheckInRepositoryImp implements CheckInRepository {
  final CheckInDataSource dataSource;

  CheckInRepositoryImp(this.dataSource);

  @override
  Future<Either<BaseFailure, bool>> checkIn(Float32List faceInfo) async =>
      dataSource.checkIn(faceInfo);

  @override
  Future<Either<BaseFailure, List<UserModel>>> getAllUsersInfo() async =>
      dataSource.getAllUsersInfo();
}
