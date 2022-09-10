import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/major.dart';

class AdminRepository {
  void stateChange(Major major, String id) {
    FirebaseFirestore.instance
        .collection('majors')
        .doc(id)
        .update({'menu': major.menu, 'openOrClose': major.openOrClose}).then((value) => print("clear!"));
  }
}