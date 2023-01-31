import 'package:face_recognize_demo/features/checkin/entities/model/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/locator/dependency_injection.dart';

List<UserModel> currentAppUsers = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initServices();
  configureDependencies();

  runApp(const MyApp());
}

Future<void> _initServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
