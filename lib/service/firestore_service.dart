import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String uid, String content) async {
    await _firestore.collection('chat').doc(uid).set({
      DateTime.now().millisecondsSinceEpoch.toString(): {
        'sender': 'client',
        'content': content,
      }
    }, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChatStream(String uid) {
    return _firestore.collection('chat').doc(uid).snapshots();
  }
}
