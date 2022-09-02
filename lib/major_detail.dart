import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MajorDetailView extends StatelessWidget {
  var id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var major = FirebaseFirestore.instance.collection('majors').doc(id).get();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: major,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const ColoredBox(
                        color: Colors.black,
                        child: SizedBox(
                          width: 30,
                          height: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data['intro'],
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 5.0,
                                offset: Offset(4, 4))
                          ]),
                      child: buildStatusText(data),
                    ),
                    Expanded(
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          HashTag(
                            content: "술파는 곳",
                          ),
                          HashTag(
                            content: "안주",
                          ),
                          HashTag(
                            content: "사람 없어서 한가해요",
                          ),
                          HashTag(
                            content: "아무나 와줘요",
                          ),
                          HashTag(
                            content: "비전타워 옆",
                          ),
                          HashTag(
                            content: "먹태는 팔아요",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    "위치",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                )
              ],
            );
          }
          return const Text("loading");
        },
      ),
    );
  }

  Text buildStatusText(Map<String, dynamic> data) {
    String? status = data['status'];
    Color color;
    switch(status) {
      case "원활": color = Colors.green; break;
      case "보통": color = Colors.amber; break;
      case "혼잡": color = Colors.red; break;
      default : color = Colors.black;
    }
    return Text(
      status ?? "모름",
      style: TextStyle(color: color, fontSize: 40.0),
    );
  }
}

class HashTag extends StatelessWidget {
  HashTag({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 5.0,
                offset: Offset(4, 4))
          ]),
      child: Text(
        "#${content}",
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
        ),
      ),
    );
  }
}
