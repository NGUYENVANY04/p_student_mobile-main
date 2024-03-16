import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/app.dart';
import 'package:p_student_mobile/global/global_data.dart';
import 'package:p_student_mobile/model/student_info.dart';
import 'package:p_student_mobile/route/router_name.dart';
import 'package:p_student_mobile/service/share_preferences_helper.dart';

class LoginVM extends ChangeNotifier {
  String errorMessage = "";

  Future<void> checkLogin({
    required String email,required String password
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      errorMessage = "Vui lòng điền đầy đủ thông tin";
      notifyListeners();
    } else {
      try {
        final student =  await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        SharedPreferencesHelper.setUid(student.user!.uid);
        GlobalData.instance.uid = student.user!.uid;
        StudentInfo? studentInfo =
            await getStudentInfo(GlobalData.instance.uid!);
        if (studentInfo != null) {
          GlobalData.instance.student = studentInfo;} else{
            return;
          }
        log('Login successful!');
               mainNavigatorKey.currentState?.pushReplacementNamed(RouterName.home);

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          log('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          log('Wrong password provided for that user.');
        }
      } catch (e) {
        log('Error: $e');
      }
    }
  }
}
