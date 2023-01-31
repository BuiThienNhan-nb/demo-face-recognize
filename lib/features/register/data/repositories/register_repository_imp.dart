import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_failure.dart';
import '../../../checkin/entities/model/user_model.dart';
import '../../entities/repositories/register_repository.dart';
import '../datasources/register_data_source.dart';

@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImp implements RegisterRepository {
  final RegisterDataSource dataSource;

  RegisterRepositoryImp(this.dataSource);

  @override
  Future<Either<BaseFailure, UserModel>> register(UserModel user) async =>
      dataSource.register(user);
}
