import 'package:flutter/material.dart';

import '../../models/Booth.dart';
import '../../models/group.dart';
import '../../models/place.dart';

class DetailCard extends StatelessWidget {
  DetailCard({required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              padding: EdgeInsets.only(right: 20.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, 0),
                        blurRadius: 11,
                        spreadRadius: 0)
                  ]),
              child: Row(
                children: [
                  buildStatusBox(),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            Container(
                              color: Colors.amber,
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text("${group.position}"),
                            ),
                            Spacer(),
                            Text(
                              Booth.values.elementAt(group.booth!).name,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          group.title!,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                group.intro!,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildCloseFilter()
          ],
        ),
      ],
    );
  }

  Container buildCloseFilter() {
    if(group.openOrClose == 0) {
      return Container(
        height: 100.0,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Center(
          child: Text(
            "CLOSE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Widget buildStatusBox() {
    if (group.booth == Booth.major.key || group.booth == Booth.congestion.key) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: statusColorBrain(group.status!),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              statusTextBrain(group.status!),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    } else if (group.booth == Booth.waiting.key) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
          child: Center(
            child: Text(
              "${group.waiting}명\n대기",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
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
