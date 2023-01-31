// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../base/base_api.dart' as _i4;
import '../../config/app_routes.dart' as _i3;
import '../../features/checkin/data/datasources/check_in_data_source.dart'
    as _i6;
import '../../features/checkin/data/repositories/check_in_repository_imp.dart'
    as _i8;
import '../../features/checkin/entities/repositories/check_in_repository.dart'
    as _i7;
import '../../features/checkin/entities/services/camera_service.dart' as _i5;
import '../../features/checkin/entities/services/face_detector_service.dart'
    as _i10;
import '../../features/checkin/entities/services/ml_service.dart' as _i12;
import '../../features/checkin/entities/usecases/check_in_use_case.dart' as _i9;
import '../../features/checkin/entities/usecases/get_all_users_use_case.dart'
    as _i11;
import '../../features/checkin/presentation/states/check_in_store.dart' as _i17;
import '../../features/register/data/datasources/register_data_source.dart'
    as _i13;
import '../../features/register/data/repositories/register_repository_imp.dart'
    as _i15;
import '../../features/register/entities/repositories/register_repository.dart'
    as _i14;
import '../../features/register/entities/usecases/register_use_case.dart'
    as _i16;
import '../../features/register/presentation/state/register_store.dart'
    as _i18; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AppRoutes>(() => _i3.AppRoutes());
  gh.lazySingleton<_i4.BaseApi>(() => _i4.BaseApi());
  gh.factory<_i5.CameraService>(() => _i5.CameraService());
  gh.lazySingleton<_i6.CheckInDataSource>(() => _i6.CheckInDataSourceImp());
  gh.lazySingleton<_i7.CheckInRepository>(
      () => _i8.CheckInRepositoryImp(get<_i6.CheckInDataSource>()));
  gh.lazySingleton<_i9.CheckInUseCase>(
      () => _i9.CheckInUseCase(get<_i7.CheckInRepository>()));
  gh.lazySingleton<_i10.FaceDetectorService>(() => _i10.FaceDetectorService());
  gh.lazySingleton<_i11.GetAllUsersUseCase>(
      () => _i11.GetAllUsersUseCase(get<_i7.CheckInRepository>()));
  gh.lazySingleton<_i12.MLService>(() => _i12.MLService());
  gh.lazySingleton<_i13.RegisterDataSource>(() => _i13.RegisterDataSourceImp());
  gh.lazySingleton<_i14.RegisterRepository>(
      () => _i15.RegisterRepositoryImp(get<_i13.RegisterDataSource>()));
  gh.lazySingleton<_i16.RegisterUseCase>(
      () => _i16.RegisterUseCase(get<_i14.RegisterRepository>()));
  gh.factory<_i17.CheckInStore>(
      () => _i17.CheckInStore(get<_i11.GetAllUsersUseCase>()));
  gh.factory<_i18.RegisterStore>(
      () => _i18.RegisterStore(get<_i16.RegisterUseCase>()));
  return get;
}
