import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:untitled/models/major.dart';
import '../models/group.dart';

class MainRepository {
  Future<void> getData(List<Group> majors, Map<String, Major> ids) async {
    final ref = FirebaseFirestore.instance.collection('majors').withConverter(
      fromFirestore: Major.fromFirestore,
      toFirestore: (Major major, _) => major.toFirestore(),
    );
    final docSnap = await ref.get();
    docSnap.docs.map((e) {
      majors.add(e.data());
      ids[e.id] = e.data();
    }).toList();
  }
}
