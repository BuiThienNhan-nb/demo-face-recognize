import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'config/app_dimens.dart';
import 'config/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<AppRoutes>();

    return ScreenUtilInit(
      designSize: AppDimens.appDesignSize,
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: router.router.routerDelegate,
        routeInformationParser: router.router.routeInformationParser,
        routeInformationProvider: router.router.routeInformationProvider,
      ),
    );
  }
}
