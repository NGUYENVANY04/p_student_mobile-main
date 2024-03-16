import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/app.dart';
import 'package:p_student_mobile/global/global_data.dart';
import 'package:p_student_mobile/model/student_info.dart';
import 'package:p_student_mobile/route/router_name.dart';
import 'package:p_student_mobile/service/share_preferences_helper.dart';

class SplashVM extends ChangeNotifier {
  Future<void> checkUid() async {
    GlobalData.instance.uid = await SharedPreferencesHelper.getUid();
    try {
      if (GlobalData.instance.uid != null) {
        StudentInfo? studentInfo =
            await getStudentInfo(GlobalData.instance.uid!);
        if (studentInfo == null) {
          mainNavigatorKey.currentState?.pushReplacementNamed(RouterName.login);
        } else {
          GlobalData.instance.student = studentInfo;
          mainNavigatorKey.currentState?.pushReplacementNamed(RouterName.home);
        }
      } else {
        mainNavigatorKey.currentState?.pushReplacementNamed(RouterName.login);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
