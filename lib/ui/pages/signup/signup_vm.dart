import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/app.dart';
import 'package:p_student_mobile/global/global_data.dart';
import 'package:p_student_mobile/model/student_info.dart';
import 'package:p_student_mobile/route/router_name.dart';
import 'package:p_student_mobile/service/share_preferences_helper.dart';

class SignUpVM extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<void> registerWithEmailAndPassword({
    required String name,
    required String school,
    required String nameClass,
    required String email,
    required String password,
    required String confirmPass,
    required String studentNumber,
  }) async {
    isLoading = true;
    notifyListeners();
    if (name == "" ||
        school == "" ||
        nameClass == "" ||
        email == "" ||
        password == "" ||
        confirmPass == "" ||
        studentNumber == "") {
      errorMessage = "Vui lòng nhập đầy đủ trường thông tin";
      notifyListeners();
    } else {
      if (password != confirmPass) {
        errorMessage = "Mật khẩu xác nhận không chính xác";
        notifyListeners();
      } else {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          try {
            await FirebaseFirestore.instance
                .collection('student_info')
                .doc(userCredential.user!.uid)
                .set({
              'name': name,
              'school': school,
              'nameClass': nameClass,
              'studentNumber': int.parse(studentNumber),
            });
            GlobalData.instance.student = StudentInfo(
              name: name,
              school: school,
              nameClass: nameClass,
              studentNumber: int.parse(studentNumber),
            );
            log('Student information added successfully!');
        SharedPreferencesHelper.setUid(userCredential.user!.uid);

            mainNavigatorKey.currentState?.pushReplacementNamed(RouterName.home);
          } catch (e) {
            log('Error: $e');
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            errorMessage = "Mật khẩu được cung cấp quá yếu.";
          } else if (e.code == 'email-already-in-use') {
            errorMessage = "Email đã được sử dụng cho tài khoản khác";
          }
        } catch (e) {
          errorMessage = e.toString();
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
