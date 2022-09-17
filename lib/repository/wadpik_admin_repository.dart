import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/group.dart';

class WadpikAdminRepository {
  Future<void> getData(List<Group> groups, List<String> ids) async {
    final ref = FirebaseFirestore.instance.collection('majors').withConverter(
      fromFirestore: Group.fromFirestore,
      toFirestore: (Group major, _) => major.toFirestore(),
    );
    final docSnap = await ref.get();
    docSnap.docs.map((e) {
      Group group = e.data();
      group.id = e.id;
      groups.add(group);
      ids.add(e.id);
    }).toList();
  }
}