import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/models/booth.dart';
import '../models/group.dart';
import '../models/place.dart';
import 'admin_view.dart';
import 'components/food_list_tile.dart';

class GroupDetailView extends StatefulWidget {
  GroupDetailView({required this.callback});
  Function callback;

  @override
  State<GroupDetailView> createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
  final TransformationController transformationController =
      TransformationController();

  TextEditingController controller = TextEditingController();

  Group group = Get.arguments;
  bool isEvent = false;

  String? id;

  void setInitialTransformation() {
    final zoomFactor = 0.7;
    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, 0.0);
    transformationController.value.setEntry(1, 3, 0.0);
  }

  Future<void> callback(Group updateGroup) async {
    await Future.delayed(Duration(seconds: 0)).then((value) {
      setState(() {
        group = updateGroup;
      });
    });
  }

  @override
  void dispose() {
    if(isEvent) {
      widget.callback();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text("학과 부스 소개"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBoothPlaceImage(),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      buildStatusBadge(),
                      SizedBox(width: 10.0,),
                      buildOpenClose()
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Container(
                        color: Colors.amber,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text("${group.position}"),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      buildTitle(context),
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
                ),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSubTitle("부스 소개"),
                      Text(
                        group.intro!,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      if (group.booth == Booth.major.key)
                        Column(
                          children: [
                            SizedBox(
                              height: 40.0,
                            ),
                            buildSubTitle("메뉴"),
                            buildMenu(group),
                            SizedBox(
                              height: 40.0,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildOpenClose() {
    if (group.openOrClose == 0) {
      return Container(
        width: 60.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: Text(
            "CLOSED",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Container();
  }

  GestureDetector buildTitle(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (group.booth! == Booth.major.key ||
            group.booth! == Booth.waiting.key ||
            group.booth! == Booth.congestion.key) {
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
                      if (controller.text == group.password) {
                        Navigator.pop(context, 'Ok');
                        isEvent = true;
                        Get.to(
                            () => AdminView(
                                  callback: callback,
                                ),
                            arguments: group);
                      } else {
                        Navigator.pop(context, 'Ok');
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text(
        group.title!,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildBoothPlaceImage() {
    setInitialTransformation();
    return Container(
      height: 270.0.h,
      child: InteractiveViewer(
        transformationController: transformationController,
        minScale: 0.5,
        constrained: false,
        child: Center(
          child: Image(
            image: AssetImage(Place.values.elementAt(group.place!).image),
          ),
        ),
      ),
    );
  }

  Widget buildMenu(Group group) {
    if (group.booth == Booth.major.key) {
      return FoodListTile(menus: group.menu!);
    }
    return Container();
  }

  Column buildSubTitle(String text) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_arrow_right_sharp),
            Text(
              text,
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          width: double.infinity,
          height: 1.5,
          color: Colors.grey.withOpacity(0.4),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Container buildStatusBadge() {
    if (group.booth == Booth.major.key) {
      return Container(
        width: 40.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: statusColorBrain(group.status!),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Center(
            child: Text(
          statusTextBrain(group.status!),
          style: TextStyle(
              color: group.status! == 1 ? Colors.black : Colors.white),
        )),
      );
    } else if (group.booth == Booth.waiting.key) {
      return Container(
        width: 70.0,
        height: 20.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Center(
            child: Text(
          "${group.waiting}명 대기",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
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
