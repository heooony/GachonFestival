import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/models/group.dart';
import 'package:untitled/repository/admin_repository.dart';

import '../models/booth.dart';
import '../models/place.dart';
import 'components/admin_food_list_tile.dart';

class AdminView extends StatefulWidget {

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  TextEditingController val = TextEditingController();
  late final AdminRepository _repository;
  int? status = 0;
  late Group group;
  late String id;
  late Function callback;

  void initialGetData() {
    List<dynamic> list = Get.arguments;
    group = list[0];
    callback = list[1];
  }

  @override
  void initState() {
    _repository = AdminRepository();
    initialGetData();
    if (group.booth == Booth.congestion.key) {
      status = group.status;
    }
    super.initState();
  }

  @override
  void dispose() {
    callback(group);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        title: buildAppBarTitle(),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Open 여부(open: check)",
                  style: TextStyle(fontSize: 17.0),
                ),
                Spacer(),
                Checkbox(
                    value: openOrCloseBrain(group.openOrClose!),
                    onChanged: (value) {
                      setState(() {
                        group.openOrClose = openOrCloseBrainInt(value!);
                      });
                    })
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            buildBody(),
            ElevatedButton(
              onPressed: () {
                if (group.booth == Booth.major.key) {
                  _repository.stateChange(group, context);
                } else if(group.booth == Booth.waiting.key) {
                  group.waiting = int.parse(val.text);
                  _repository.waitingChange(group, context);
                } else if(group.booth == Booth.congestion.key) {
                  _repository.statusChange(group, context);
                }
              },
              child: Text("저장"),
            ),
          ],
        ),
      ),
    );
  }

  Text buildAppBarTitle() {
    if(group.booth == Booth.major.key) return Text("오픈여부/메뉴 품절 상태 변경");
    else if(group.booth == Booth.waiting.key) return Text("오픈여부/대기자 변경");
    else if(group.booth == Booth.congestion.key) return Text("오픈여부/혼잡도 변경");
    else return Text("관리자모드");
  }

  Widget buildBody() {
    if (group.booth == Booth.major.key) {
      return Expanded(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text("혼잡도", style: TextStyle(fontSize: 17.0),),
                  Spacer(),
                  buildGestureDetector(0, "원활"),
                  buildGestureDetector(1, "보통"),
                  buildGestureDetector(2, "혼잡"),
                ],
              ),
            ),
            if (group.menu != null)
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: group.menu!.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        AdminFoodListTile(menu: group.menu!.values.elementAt(index)),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      );
    } else if (group.booth == Booth.waiting.key) {
      return Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text("대기자 수", style: TextStyle(fontSize: 17.0),),
              Spacer(),
              Container(
                width: 50.0,
                height: 50.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: val,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      );
    } else if (group.booth == Booth.congestion.key) {
      return Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text("혼잡도", style: TextStyle(fontSize: 17.0),),
              Spacer(),
              buildGestureDetector(0, "원활"),
              buildGestureDetector(1, "보통"),
              buildGestureDetector(2, "혼잡"),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      );
    }
    return Container();
  }

  GestureDetector buildGestureDetector(int i, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          group.status = i;
          status = i;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
        child: Text(
          name,
          style: TextStyle(
            color: group.status == i ? Colors.white : Colors.indigo,
            fontSize: 20.0,
          ),
        ),
        decoration: BoxDecoration(
            color: group.status == i ? Colors.indigo : Colors.white),
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
    if (status)
      return 1;
    else
      return 0;
  }
}
