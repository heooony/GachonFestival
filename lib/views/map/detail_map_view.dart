import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/club.dart';
import 'package:untitled/models/flea_market.dart';
import 'package:untitled/models/food_court.dart';
import 'package:untitled/models/major.dart';
import 'package:untitled/repository/main_repository.dart';
import 'package:untitled/views/map/map_controller.dart';

import '../../models/group.dart';
import '../components/detail_card.dart';
import '../major_detail.dart';

class DetailMapView extends StatefulWidget {
  const DetailMapView({Key? key}) : super(key: key);

  @override
  State<DetailMapView> createState() => _DetailMapView();
}

class _DetailMapView extends State<DetailMapView> {
  late final MainRepository _mainRepository;
  late final MapController _mapController;
  final TransformationController transformationController =
      TransformationController();

  bool isGroupClick = false;
  Group? selectedGroup;
  int? selectedIndex;
  late final String imagePath;

  List<Group> groups = [];
  Map<String, Major> ids = {};

  late final Future myFuture;

  @override
  void initState() {
    _mainRepository = MainRepository();
    _mapController = MapController();
    // 구역 클릭시
    // 초기 map위치 지정
    setInitialTransformation();
    // drawer에서 클릭시
    checkEntryRoute();
    super.initState();
  }

  void checkEntryRoute() {
    List<Object> arguments = Get.arguments;
    if (arguments.length == 1) {
      groups = arguments[0] as List<Group>;
    } else if (arguments.length != 1) {
      groups = arguments[0] as List<Group>;
      int index = arguments[1] as int;
      double w = arguments[2] as double;
      double h = arguments[3] as double;

      selectedGroup = groups[index];
      selectedIndex = index;
      isGroupClick = true;
      setTransformation(w, h, groups[index].xPosition!, groups[index].yPosition!);
    }
    imagePath = _mapController.getImagePath(groups[0]);
  }

  /**
   * 초기 지도 위치 세팅
   */
  void setInitialTransformation() {
    final zoomFactor = 0.5;
    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, 0.0);
    transformationController.value.setEntry(1, 3, 0.0);
  }

  /**
   * 각 위치 클릭시 지도 이동, zoom 설정
   */
  void setTransformation(double w, double h, double x, double y) {
    final zoomFactor = 0.5;
    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -x * zoomFactor + w / 2 - 20);
    transformationController.value.setEntry(1, 3, -y * zoomFactor + h / 2 - 50);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: buildAppBar(),
      endDrawer: buildDrawer(width, height),
      body: buildMain(width, height),
      backgroundColor: Colors.white,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      title: Text('Wadpik'),
    );
  }

  Stack buildMain(double width, double height) {
    return Stack(
      children: [
        InteractiveViewer(
          transformationController: transformationController,
          maxScale: 3.0,
          minScale: 0.5,
          constrained: false,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGroupClick = false;
                  });
                },
                child: Image(
                  image: AssetImage(imagePath),
                ),
              ),
              for (var group in groups)
                Positioned(
                  left: group.xPosition,
                  top: group.yPosition,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isGroupClick = true;
                        selectedGroup = group;
                        setTransformation(
                            width, height, group.xPosition!, group.yPosition!);
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(group.iconImagePath),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (!isGroupClick)
          Container()
        else
          GestureDetector(
            onTap: () {
              if (selectedGroup is Major) {
                String id = "";
                ids.forEach((key, value) {
                  if (selectedGroup == value) {
                    id = key;
                  }
                });
                Get.to(() => MajorDetailView(), arguments: [selectedGroup, id]);
              }
            },
            child: DetailCard(group: selectedGroup!),
          )
      ],
    );
  }

  Drawer buildDrawer(double width, double height) {
    return Drawer(child: buildTabBarView(groups, width, height));
  }

  SizedBox buildTabBarView(List<Group> groups, double width, double height) {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int index) {
          bool openOrClose = groups[index].openOrClose == 1 ? true : false;
          return ListTile(
            title: Text(
              groups[index].title!,
              style: TextStyle(color: openOrClose ? Colors.black : Colors.grey),
            ),
            trailing: openOrClose
                ? Text("")
                : Text(
                    "CLOSE",
                    style: TextStyle(color: Colors.red),
                  ),
            onTap: () {
              setState(
                () {
                  selectedIndex = index;
                  selectedGroup = groups[index];
                  isGroupClick = true;
                  setTransformation(width, height, groups[index].xPosition!,
                      groups[index].yPosition!);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }

  Color colorBrain(int status) {
    if (status == 0)
      return Colors.green;
    else if (status == 1)
      return Colors.amber;
    else
      return Colors.red;
  }
}

class GroupTab extends StatelessWidget {
  GroupTab({required this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
