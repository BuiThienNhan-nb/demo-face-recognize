// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:face_recognize_demo/base/base_failure.dart';
import 'package:face_recognize_demo/base/base_use_case.dart';
import 'package:face_recognize_demo/features/checkin/entities/model/user_model.dart';
import 'package:face_recognize_demo/features/register/entities/repositories/register_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RegisterUseCase extends BaseUseCase<UserModel, RegisterUseCaseParams> {
  final RegisterRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<BaseFailure, UserModel>> call(
          RegisterUseCaseParams params) async =>
      _repository.register(params.user);
}

class RegisterUseCaseParams extends Equatable {
  final UserModel user;

  const RegisterUseCaseParams({required this.user});

  @override
  List<Object?> get props => [user];
}
