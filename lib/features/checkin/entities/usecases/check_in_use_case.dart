// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:face_recognize_demo/base/base_failure.dart';
import 'package:face_recognize_demo/base/base_use_case.dart';
import 'package:face_recognize_demo/features/checkin/entities/repositories/check_in_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckInUseCase extends BaseUseCase<bool, CheckInUseCaseParams> {
  final CheckInRepository _repository;

  CheckInUseCase(this._repository);

  @override
  Future<Either<BaseFailure, bool>> call(CheckInUseCaseParams params) async =>
      _repository.checkIn(params.faceInfo);
}

class CheckInUseCaseParams extends Equatable {
  final Float32List faceInfo;

  const CheckInUseCaseParams({required this.faceInfo});

  @override
  List<Object?> get props => [faceInfo];
}
