import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/major.dart';

class WadpikAdminRepository {
  Future<void> getData(List<Major> majors, List<String> ids) async {
    final ref = FirebaseFirestore.instance.collection('majors').withConverter(
      fromFirestore: Major.fromFirestore,
      toFirestore: (Major major, _) => major.toFirestore(),
    );
    final docSnap = await ref.get();
    docSnap.docs.map((e) {
      majors.add(e.data());
      ids.add(e.id);
    }).toList();
  }
}