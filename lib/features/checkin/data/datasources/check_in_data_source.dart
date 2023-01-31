import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:face_recognize_demo/base/base_api.dart';
import 'package:face_recognize_demo/main.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/base_failure.dart';
import '../../entities/model/user_model.dart';

abstract class CheckInDataSource {
  Future<Either<BaseFailure, bool>> checkIn(Float32List faceInfo);
  Future<Either<BaseFailure, List<UserModel>>> getAllUsersInfo();
}

@LazySingleton(as: CheckInDataSource)
class CheckInDataSourceImp extends BaseApi implements CheckInDataSource {
  @override
  Future<Either<BaseFailure, bool>> checkIn(Float32List faceInfo) async {
    try {
      // Fake check in Implementation
      final check = currentAppUsers.any((user) => user.faceInfo == faceInfo);
      return Right(check);
    } catch (e) {
      return Left(UserFailure(e.toString()));
    }
  }

  @override
  Future<Either<BaseFailure, List<UserModel>>> getAllUsersInfo() async {
    try {
      List<UserModel>? users;
      await collection("users").get().then(
        (querySnapshot) {
          users = [];
          for (var element in querySnapshot.docs) {
            users!.add(UserModel.fromMap(element.data()));
          }
        },
      ).catchError((err) {
        throw Exception(err);
      });
      if (users == null) {
        throw Exception("Cannot read data from Firestore");
      }
      return Right(users!);
    } catch (e) {
      return Left(UserFailure(e.toString()));
    }
  }
}
