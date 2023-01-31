import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../base/base_failure.dart';
import '../../../../base/base_state.dart';
import '../../../../base/base_use_case.dart';
import '../../entities/model/user_model.dart';
import '../../entities/usecases/get_all_users_use_case.dart';

part 'check_in_store.g.dart';

@injectable
class CheckInStore extends _CheckInStore with _$CheckInStore {
  CheckInStore(super.useCase);
}

abstract class _CheckInStore with Store {
  final GetAllUsersUseCase _useCase;

  _CheckInStore(this._useCase);

  @observable
  String? errorMessage;

  @observable
  ObservableFuture<Either<BaseFailure, List<UserModel>>>? _getAllUsers;

  @computed
  BaseState get state {
    if (_getAllUsers == null) {
      return BaseState.init;
    }
    if (_getAllUsers!.status == FutureStatus.rejected) {
      return BaseState.error;
    }
    return _getAllUsers!.status == FutureStatus.pending
        ? BaseState.loading
        : BaseState.loaded;
  }

  @action
  Future<void> getAllUsers() async {
    errorMessage = null;

    _getAllUsers = ObservableFuture(
      _useCase.call(
        NoParams(),
      ),
    );

    Either<BaseFailure, List<UserModel>>? result = await _getAllUsers;

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
      (r) {},
    );
  }
}
