import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/major_detail.dart';

class MajorListView extends StatelessWidget {
  const MajorListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> majorsStream = FirebaseFirestore.instance.collection('majors').snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: majorsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name']),
                onTap: () {
                  Get.to(() => MajorDetailView(), arguments: document.id);
                },
              );
            }).toList(),
          );
        },
      )
    );
  }
}
