import 'package:flutter/material.dart';

import '../../models/major.dart';
import '../admin_view.dart';
import 'package:get/get.dart';

class DetailInfoCard extends StatelessWidget {
  DetailInfoCard({required this.major, required this.id});

  final Major major;
  final String id;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                offset: Offset(0, 0),
                blurRadius: 11,
                spreadRadius: 0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onDoubleTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('관리자 비밀번호'),
                    content: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(hintText: "비밀번호"),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (controller.text == major.password) {
                            Navigator.pop(context, 'Cancel');
                            Get.to(() => AdminView(), arguments: [major, id]);
                          } else {
                            Navigator.pop(context, 'Cancel');
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              major.title!,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 14,
                color: Colors.black.withOpacity(0.8),
              ),
              SizedBox(
                width: 1.0,
              ),
              Text(
                "13",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  major.intro!,
                  maxLines: 3,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: statusColorBrain(major.status!),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Center(
                  child: Text(
                    statusTextBrain(major.status!),
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color statusColorBrain(int status) {
    if (status == 0)
      return Colors.green;
    else if (status == 1)
      return Colors.amber;
    else if (status == 2)
      return Colors.red;
    else
      return Colors.white;
  }

  String statusTextBrain(int status) {
    if (status == 0)
      return "원활";
    else if (status == 1)
      return "보통";
    else if (status == 2)
      return "혼잡";
    else
      return "모름";
  }
}
