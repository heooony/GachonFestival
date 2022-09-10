import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/major.dart';
import 'package:untitled/repository/admin_repository.dart';

import 'components/admin_food_list_tile.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {

  late final AdminRepository _repository;
  late Major major;
  late String id;

  void initialGetData() {
    List<dynamic> list = Get.arguments;
    major = list[0];
    id = list[1];
  }

  @override
  void initState() {
    initialGetData();
    super.initState();
  }

  @override
  void dispose() {
    _repository = AdminRepository();
    _repository.stateChange(major, id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text("메뉴 품절 상태 변경"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Open 여부(open: check)", style: TextStyle(fontSize: 20.0),),
                Spacer(),
                Checkbox(
                    value: openOrCloseBrain(major.openOrClose!),
                    onChanged: (value) {
                      setState(() {
                        major.openOrClose = openOrCloseBrainInt(value!);
                      });
                    }
                )
              ],
            ),
            for (var menu in major.menu.values)
              Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  AdminFoodListTile(menu: menu),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  bool openOrCloseBrain(int status) {
    if (status == 1)
      return true;
    else
      return false;
  }

  int openOrCloseBrainInt(bool status) {
    if (status) return 1;
    else return 0;
  }
}