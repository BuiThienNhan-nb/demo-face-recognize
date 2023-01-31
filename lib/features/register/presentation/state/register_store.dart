import 'package:dartz/dartz.dart';
import 'package:face_recognize_demo/features/checkin/entities/model/user_model.dart';
import 'package:face_recognize_demo/features/register/entities/usecases/register_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../base/base_failure.dart';
import '../../../../base/base_state.dart';

part 'register_store.g.dart';

@injectable
class RegisterStore extends _RegisterStore with _$RegisterStore {
  RegisterStore(super.useCase);
}

abstract class _RegisterStore with Store {
  final RegisterUseCase _useCase;

  _RegisterStore(this._useCase);

  @observable
  UserModel? user;

  @observable
  String? errorMessage;

  @observable
  ObservableFuture<Either<BaseFailure, UserModel>>? _register;

  @computed
  BaseState get state {
    if (_register == null) {
      return BaseState.init;
    }
    if (_register!.status == FutureStatus.rejected) {
      return BaseState.error;
    }
    return _register!.status == FutureStatus.pending
        ? BaseState.loading
        : BaseState.loaded;
  }

  @action
  Future<void> register(UserModel user) async {
    errorMessage = null;

    _register = ObservableFuture(
      _useCase.call(
        RegisterUseCaseParams(user: user),
      ),
    );

    Either<BaseFailure, UserModel>? result = await _register;

    if (result == null) {
      errorMessage = "Cannot call api!";
      return;
    }

    return result.fold(
      (l) {
        (l is UserFailure || l is ServerFailure)
            ? errorMessage = l.message
            : "Unexpected error!";
      },
      (r) => this.user = r,
    );
  }
}
