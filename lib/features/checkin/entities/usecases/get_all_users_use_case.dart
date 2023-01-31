import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_failure.dart';
import '../../../../base/base_use_case.dart';
import '../model/user_model.dart';
import '../repositories/check_in_repository.dart';

@lazySingleton
class GetAllUsersUseCase extends BaseUseCase<List<UserModel>, NoParams> {
  final CheckInRepository _repository;

  GetAllUsersUseCase(this._repository);

  @override
  Future<Either<BaseFailure, List<UserModel>>> call(NoParams params) async =>
      _repository.getAllUsersInfo();
}
