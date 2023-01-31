import 'package:equatable/equatable.dart';

abstract class BaseFailure extends Equatable {
  const BaseFailure([List properties = const <dynamic>[]]) : super();

  String? get message => null;
}

class ServerFailure extends BaseFailure {
  @override
  final String message;

  const ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UserFailure extends BaseFailure {
  @override
  final String message;

  const UserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
