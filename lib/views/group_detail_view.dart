import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/models/booth.dart';
import 'package:untitled/utils/wad_analytics.dart';
import 'package:untitled/views/map/main_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/group.dart';
import '../models/place.dart';
import 'admin_view.dart';
import 'components/food_list_tile.dart';

class GroupDetailView extends StatefulWidget {
  @override
  State<GroupDetailView> createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
  TextEditingController controller = TextEditingController();

  late Group group;
  late Function refresh;
  bool isEvent = false;

  String? id;

  Future<void> callback(Group updateGroup) async {
    await Future.delayed(Duration(seconds: 0)).then((value) {
      setState(() {
        group = updateGroup;
      });
    });
  }

  void setReservation() {
    WadAnalytics.setReservation(Booth.values.elementAt(group.booth!).name);
  }

  @override
  void initState() {
    List<dynamic> list = Get.arguments;
    group = list[0];
    refresh = list[1];
    super.initState();
  }

  @override
  void dispose() {
    if (isEvent) {
      refresh();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text("부스 소개"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildBoothPlaceImage(width),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [buildStatusBadge(), buildOpenClose()],
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text("전화번호 : ", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                      buildPhoneCopy(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text("계좌번호 : ", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
                      buildAccount(),
                    ],
                  ),
                ),
                if(group.link != null)
                  buildLink(),
                buildTime(),
                SizedBox(height: 20.0,),
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
                      if(group.menu != null)
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
                      SizedBox(
                        height: 60.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          buildReservationButton(context)
        ],
      ),
    );
  }

  Widget buildPhoneCopy() {
    if (group.phone != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Text(group.phone!, style: TextStyle(fontSize: 15.0, color: Colors.grey),),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(5.0),
                foregroundColor: Colors.indigo
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: group.phone!));
              },
              child: Text("복사"),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget buildAccount() {
    if (group.account != null) {
      return Row(
        children: [
          Text("${group.account!}", style: TextStyle(fontSize: 15.0, color: Colors.grey)),
          TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(5.0),
                foregroundColor: Colors.indigo
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: group.account!));
            },
            child: Text("복사"),
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildLink() {
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: Colors.indigo
      ),
      onPressed: () async {
        Uri uri = Uri.parse(group.link!);
        if (!await launchUrl(uri)) {
          throw 'Could not launch $uri';
        }
      },
      child: Text("인스타그램 링크"),
    );
  }

  Widget buildTime() {
    if (group.start != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Text("운영시간 : ${group.start}시 ~ ", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
            if(group.end != null)
              Text("${group.end}시", style: TextStyle(fontSize: 15.0, color: Colors.grey),),
          ],
        ),
      );
    }
    return Container();
  }

  Widget buildReservationButton(BuildContext context) {
    if (group.booth == Booth.major.key || group.booth == Booth.waiting.key) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          ElevatedButton(
            onPressed: () {
              setReservation();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    icon: Icon(Icons.face_unlock_sharp),
                    title: const Text('예약 기능 준비 중'),
                    content: Text("해당 기능은 열심히 개발하고 있습니다! 조금만 기다려주세요:)"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Ok');
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(double.infinity, 60.0),
                backgroundColor: Colors.indigo),
            child: Text(
              "자리 예약하기",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Container buildOpenClose() {
    if (group.openOrClose == 0) {
      return Container(
        width: 60.0,
        height: 20.0,
        margin: EdgeInsets.only(left: 20.0),
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
          if(MainView.isMaster) {
            Navigator.pop(context, 'Ok');
            isEvent = true;
            Get.toNamed('/admin', arguments: [group, callback]);
          } else {
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
                        if (controller.text == group.password || controller.text == "wad316") {
                          if(controller.text == "wad316") {
                            MainView.isMaster = true;
                          }
                          Navigator.pop(context, 'Ok');
                          isEvent = true;
                          Get.toNamed('/admin', arguments: [group, callback]);
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
        }
      },
      child: Text(
        group.title!,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  ConstrainedBox buildBoothPlaceImage(double widthSize) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300.0.h),
      child: Container(
        height: widthSize,
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: AssetImage(Place.values.elementAt(group.place!).image),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu(Group group) {
    if (group.menu != null) {
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
    if (group.booth == Booth.major.key || group.booth == Booth.congestion.key) {
      return Container(
        width: 40.0,
        height: 20.0,
        margin: EdgeInsets.only(left: 20.0),
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
        margin: EdgeInsets.only(left: 20.0),
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
