import 'package:dartz/dartz.dart';
import 'package:face_recognize_demo/base/base_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_failure.dart';
import '../../../checkin/entities/model/user_model.dart';

abstract class RegisterDataSource {
  Future<Either<BaseFailure, UserModel>> register(UserModel user);
}

@LazySingleton(as: RegisterDataSource)
class RegisterDataSourceImp extends BaseApi implements RegisterDataSource {
  @override
  Future<Either<BaseFailure, UserModel>> register(UserModel user) async {
    try {
      await collection("users").add(user.toMap()).catchError(
            (err) => throw Exception(err),
          );
      // data.get();
      // await collection("users").add(user.toMap()).then(
      //   (value) {
      //     value.snapshots().map(
      //         (snapshot) => returnUser = UserModel.fromMap(snapshot.data()!));
      //   },
      // ).catchError(
      //   (err) => throw Exception(err),
      // );
      // if (returnUser == null) {
      //   throw Exception("Cannot get or convert data from Document!!");
      // }
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
