import 'package:flutter/material.dart';

import '../../models/club.dart';
import '../../models/group.dart';
import '../../models/major.dart';

class DetailCard extends StatelessWidget {
  DetailCard({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 190,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0, 0),
                        blurRadius: 11,
                        spreadRadius: 0)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        group.title!,
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      buildIcon()
                    ],
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
                      Text("13",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.7))),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          group.intro!,
                          maxLines: 3,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      buildStatusBox(),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            if (group.openOrClose! == 0)
              Container(
                width: double.infinity,
                height: 190,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Center(
                  child: Text(
                    "CLOSE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget buildIcon() {
    if (group is Major || group is Club) {
      return Icon(
        Icons.arrow_forward_ios_sharp,
        size: 14.0,
      );
    } else {
      return Container();
    }
  }

  Container buildStatusBox() {
    Major major;
    if (group is Major) {
      major = group as Major;
      return Container(
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
      );
    }
    return Container();
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
