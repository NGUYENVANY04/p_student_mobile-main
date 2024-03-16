import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class StudentInfo{
  String name = "";
  String nameClass = "";
  String school = "";
  int studentNumber = 0;


  StudentInfo({
    required this.name,
    required this.school,
    required this.nameClass,
    required this.studentNumber,
  });

 factory StudentInfo.fromMap(Map<String, dynamic> map) {
    return StudentInfo(
      name: map['name'] ?? '',
      school: map['school'] ?? '',
      nameClass: map['nameClass'] ?? '',
      studentNumber: map['studentNumber'] ?? 0,
    );
  }
}

Future<StudentInfo?> getStudentInfo(String uid) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('student_info').doc(uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      return StudentInfo.fromMap(data);
    } else {
      log('No student_info found for UID: $uid');
      return null;
    }
  } catch (e) {
    log('Error: $e');
    return null;
  }
}