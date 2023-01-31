import 'package:face_recognize_demo/features/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

import '../features/checkin/presentation/pages/check_in_page.dart';
import '../features/checkin/presentation/states/check_in_store.dart';
import '../features/register/presentation/pages/register_page.dart';
import '../features/register/presentation/state/register_store.dart';

@lazySingleton
class AppRoutes {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  final String home = "/home";
  final String checkIn = "check-in";
  final String registerFace = "face/register";

  String get initial => home;

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initial,
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text("/ERROR"),
      ),
    ),
    routes: [
      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: registerFace,
            name: "register_face",
            builder: (context, state) => Provider<RegisterStore>(
              create: (_) => GetIt.I(),
              lazy: true,
              child: const RegisterPage(),
            ),
          ),
          GoRoute(
            path: checkIn,
            name: "check_in",
            builder: (context, state) => Provider<CheckInStore>(
              create: (_) => GetIt.I(),
              lazy: true,
              child: const CheckInPage(),
            ),
          ),
        ],
      ),
    ],
  );
}
