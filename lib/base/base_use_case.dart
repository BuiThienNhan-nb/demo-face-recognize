import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'base_failure.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<BaseFailure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
