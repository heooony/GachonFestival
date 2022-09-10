import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/major.dart';
import 'components/detail_info_card.dart';
import 'components/food_list_tile.dart';

class MajorDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<dynamic> list = Get.arguments;
    Major major = list[0];
    String id = list[1];

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
            DetailInfoCard(
              major: major,
              id: id,
            ),
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
                  for (var menu in major.menu.values)
                    Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        FoodListTile(menu: menu),
                        SizedBox(
                          height: 10.0,
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