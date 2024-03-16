import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/app.dart';
import 'package:p_student_mobile/route/app_router.dart';
import 'package:p_student_mobile/service/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppRouter.defineRoutes();

  runApp(const MyApp());
}
