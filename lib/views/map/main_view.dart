import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/club.dart';
import 'package:untitled/models/flea_market.dart';
import 'package:untitled/models/food_court.dart';
import 'package:untitled/models/major.dart';
import 'package:untitled/repository/main_repository.dart';
import 'package:untitled/views/map/detail_map_view.dart';

import '../../models/group.dart';
import '../components/detail_card.dart';
import '../major_detail.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final TransformationController transformationController =
  TransformationController();

  late final MainRepository _mainRepository;

  int? selectedIndex;

  List<Major> majors = [];
  List<Club> clubs = [];
  List<FoodCourt> foodCourts = [];
  List<FleaMarket> fleaMarkets = [];
  List<List<Group>> groups = [];
  Map<String, Major> ids = {};

  late final Future myFuture;

  @override
  void initState() {
    _mainRepository = MainRepository();
    getAllData();
    setInitialTransformation();
    super.initState();
  }

  getAllData() {
    myFuture = _mainRepository.getData(majors, ids);
    getInitialData();
  }

  void getInitialData() {
    clubs = Club.initialData;
    foodCourts = FoodCourt.initialData;
    fleaMarkets = FleaMarket.initialData;
    groups.add(majors);
    groups.add(clubs);
    groups.add(foodCourts);
    groups.add(fleaMarkets);
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: buildAppBar(),
          endDrawer: buildDrawer(width, height),
          body: Stack(
            children: [
              InteractiveViewer(
                transformationController: transformationController,
                maxScale: 3.0,
                minScale: 0.5,
                constrained: false,
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage("assets/images/map/gachon-map.png"),
                    ),
                    buildMajor(),
                    buildClub(),
                    buildFoodCourt(),
                    buildFleaMarket(),
                  ],
                ),
              ),
              /**
               * argument -> detail_map_view에서 각 그룹을 구별하기 위한 장치
               * 0 : 부스
               * 1 : 동아리
               * 2 : 푸드코트
               * 3 : 플리마켓
               */
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  Container(
                    width: 150,
                    height: 200,
                    margin: EdgeInsets.all(20.0),
                    decoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.6)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InfoSquare(color: Colors.blue, text: "부스"),
                        InfoSquare(color: Colors.brown, text: "동아리"),
                        InfoSquare(color: Colors.green, text: "푸드코트"),
                        InfoSquare(color: Colors.red, text: "플리마켓"),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Text(
                        "배너",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  HotSpotBox buildMajor() {
    return HotSpotBox(
      left: 760,
      top: 420,
      width: 100,
      height: 200,
      color: Colors.blue,
      groups: majors,
    );
  }

  HotSpotBox buildClub() {
    return HotSpotBox(
      left: 680,
      top: 740,
      width: 80,
      height: 80,
      color: Colors.brown,
      groups: clubs,
    );
  }

  HotSpotBox buildFoodCourt() {
    return HotSpotBox(
      left: 700,
      top: 630,
      width: 130,
      height: 90,
      color: Colors.green,
      groups: foodCourts,
    );
  }

  HotSpotBox buildFleaMarket() {
    return HotSpotBox(
      left: 130,
      top: 1130,
      width: 100,
      height: 100,
      color: Colors.red,
      groups: fleaMarkets,
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

  Drawer buildDrawer(double width, double height) {
    return Drawer(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black,
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/logo.png"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  TabBar(
                    labelPadding: EdgeInsets.all(0.0),
                    padding: EdgeInsets.all(0.0),
                    indicatorColor: Colors.black,
                    tabs: [
                      GroupTab(
                        text: "부스",
                      ),
                      GroupTab(
                        text: "동아리",
                      ),
                      GroupTab(
                        text: "푸드코트",
                      ),
                      GroupTab(
                        text: "플리마켓",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(children: [
                buildTabBarView(majors, width, height),
                buildTabBarView(clubs, width, height),
                buildTabBarView(foodCourts, width, height),
                buildTabBarView(fleaMarkets, width, height),
              ]),
            )
          ],
        ),
      ),
    );
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
                  Navigator.pop(context);
                  Get.to(() => DetailMapView(),
                      arguments: [groups, index, width, height]);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class InfoSquare extends StatelessWidget {
  InfoSquare({
    required this.color,
    required this.text,
  });

  final color;
  final text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35.0,
          height: 35.0,
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(color: color.withOpacity(0.5)),
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        )
      ],
    );
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

class HotSpotBox extends StatelessWidget {
  HotSpotBox(
      {required this.left,
      required this.top,
      required this.width,
      required this.height,
      required this.color,
      required this.groups});

  final left;
  final top;
  final width;
  final height;
  final color;
  final groups;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => Get.to(() => DetailMapView(), arguments: [groups]),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            border: Border.all(color: color.withOpacity(0.5), width: 2.0),
          ),
          child: Center(
              // child: Text(text),
              ),
        ),
      ),
    );
  }
}
