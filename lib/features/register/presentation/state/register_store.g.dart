// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on _RegisterStore, Store {
  Computed<BaseState>? _$stateComputed;

  @override
  BaseState get state => (_$stateComputed ??=
          Computed<BaseState>(() => super.state, name: '_RegisterStore.state'))
      .value;

  late final _$userAtom = Atom(name: '_RegisterStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_RegisterStore.errorMessage', context: context);

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

  late final _$_registerAtom =
      Atom(name: '_RegisterStore._register', context: context);

  @override
  ObservableFuture<Either<BaseFailure, UserModel>>? get _register {
    _$_registerAtom.reportRead();
    return super._register;
  }

  @override
  set _register(ObservableFuture<Either<BaseFailure, UserModel>>? value) {
    _$_registerAtom.reportWrite(value, super._register, () {
      super._register = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_RegisterStore.register', context: context);

  @override
  Future<void> register(UserModel user) {
    return _$registerAsyncAction.run(() => super.register(user));
  }

  @override
  String toString() {
    return '''
user: ${user},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
