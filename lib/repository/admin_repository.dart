import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/group.dart';

class AdminRepository {
  void stateChange(Group group, BuildContext context) {
    FirebaseFirestore.instance.collection('majors').doc(group.id).update(
        {'menu': group.menu, 'openOrClose': group.openOrClose}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장되었습니다.'),
        ),
      );
    });
  }

  void waitingChange(Group group, BuildContext context) {
    FirebaseFirestore.instance.collection('majors').doc(group.id).update(
        {'openOrClose': group.openOrClose, 'waiting': group.waiting}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장되었습니다.'),
        ),
      );
    });
  }

  void statusChange(Group group, BuildContext context) {
    FirebaseFirestore.instance.collection('majors').doc(group.id).update(
        {'openOrClose': group.openOrClose, 'status': group.status}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('저장되었습니다.'),
        ),
      );
    });
  }
}
