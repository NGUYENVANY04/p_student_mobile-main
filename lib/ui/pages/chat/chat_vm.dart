import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/service/firestore_service.dart';

class ChatVM extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChatStream(String uid) {
    return _firestoreService.getChatStream(uid);
  }

  Future<void> sendMessage(String uid, String content) async {
    await _firestoreService.sendMessage(uid, content);
  }
}