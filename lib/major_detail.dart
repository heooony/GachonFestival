import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'model/major.dart';

class MajorDetailView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Major major = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text("학과 부스 소개"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            DetailInfoCard(major: major),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.all(20.0),
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
                children: [
                  Text(
                    "메뉴",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  for (int i = 0; i < 7; i++)
                    Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        FoodListTile(menus: major.menu),
                        SizedBox(
                          height: 10.0,
                        ),
                        if (i != 6)
                          Divider(
                            color: Colors.black.withOpacity(0.3),
                          ),
                      ],
                    )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}

class FoodListTile extends StatelessWidget {
  FoodListTile({required this.menus});
  final LinkedHashMap<String, dynamic> menus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: menus.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "김치볶음밥",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "6000원",
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "어머니께서 해준 것 같은 정말 맛있는 김치볶음밥",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              );
            }
        )
      ],
    );
  }
}

class DetailInfoCard extends StatelessWidget {
  DetailInfoCard({required this.major});

  final major;

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
          Text(
            major.major,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
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
                  major.intro,
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
                  color: statusColorBrain(major.status),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Center(
                  child: Text(
                    statusTextBrain(major.status),
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
    if (status == 0) return Colors.green;
    else if (status == 1) return Colors.amber;
    else if (status == 2) return Colors.red;
    else return Colors.white;
  }

  String statusTextBrain(int status) {
    if (status == 0) return "원활";
    else if (status == 1) return "보통";
    else if (status == 2) return "혼잡";
    else return "모름";
  }
}
