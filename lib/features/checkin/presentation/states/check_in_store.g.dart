// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckInStore on _CheckInStore, Store {
  Computed<BaseState>? _$stateComputed;

  @override
  BaseState get state => (_$stateComputed ??=
          Computed<BaseState>(() => super.state, name: '_CheckInStore.state'))
      .value;

  late final _$errorMessageAtom =
      Atom(name: '_CheckInStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$_getAllUsersAtom =
      Atom(name: '_CheckInStore._getAllUsers', context: context);

  @override
  ObservableFuture<Either<BaseFailure, List<UserModel>>>? get _getAllUsers {
    _$_getAllUsersAtom.reportRead();
    return super._getAllUsers;
  }

  @override
  set _getAllUsers(
      ObservableFuture<Either<BaseFailure, List<UserModel>>>? value) {
    _$_getAllUsersAtom.reportWrite(value, super._getAllUsers, () {
      super._getAllUsers = value;
    });
  }

  late final _$getAllUsersAsyncAction =
      AsyncAction('_CheckInStore.getAllUsers', context: context);

  @override
  Future<void> getAllUsers() {
    return _$getAllUsersAsyncAction.run(() => super.getAllUsers());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
