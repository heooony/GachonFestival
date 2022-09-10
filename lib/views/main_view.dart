import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/club.dart';
import 'package:untitled/models/flea_market.dart';
import 'package:untitled/models/food_court.dart';
import 'package:untitled/models/major.dart';
import 'package:untitled/repository/main_repository.dart';

import '../models/group.dart';
import 'components/detail_card.dart';
import 'major_detail.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final MainRepository _mainRepository;
  final TransformationController transformationController =
      TransformationController();

  bool isGroupClick = false;

  Group? selectedGroup;
  int? selectedIndex;

  // 각 지역적 위치 리스트
  List<Major> majors = [];
  List<Club> clubs = [];
  List<FoodCourt> foodCourts = [];
  List<FleaMarket> fleaMarkets = [];
  List<List<Group>> groups = [];

  List<String> ids = [];

  late final Future myFuture;

  /**
   * majors, clubs, flea-merket, food-court 정보 가져오기
   */
  getAllData() {
    myFuture = _mainRepository.getData(majors, ids);
    getInitialData();
  }

  /**
   * database 연동 x, model의 initialData 가져오기
   */
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
    final zoomFactor = 1.0;
    final xTranslate = 1270.0;
    final yTranslate = 0.0;
    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -xTranslate);
    transformationController.value.setEntry(1, 3, -yTranslate);
  }

  /**
   * 각 위치 클릭시 지도 이동, zoom 설정
   */
  void setTransformation(double w, double h, double x, double y) {
    final zoomFactor = 2.0;
    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, -x * zoomFactor + w / 2 - 20);
    transformationController.value.setEntry(1, 3, -y * zoomFactor + h / 2 - 50);
  }

  @override
  void initState() {
    _mainRepository = MainRepository();
    getAllData();
    setInitialTransformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.0,
              title: Text('가천대 지도 & 혼잡도 확인'),
            ),
            drawer: Drawer(
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
                                        fit: BoxFit.cover
                                    )
                                ),
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
            ),
            body: Stack(
              children: [
                InteractiveViewer(
                  transformationController: transformationController,
                  maxScale: 5.0,
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
                          image: AssetImage("assets/images/gachon-map.png"),
                        ),
                      ),
                      for (var group in groups)
                        for (int j = 0; j < group.length; j++)
                          Positioned(
                            left: group[j].xPosition,
                            top: group[j].yPosition,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGroupClick = true;
                                  selectedGroup = group[j];
                                  setTransformation(width, height,
                                      group[j].xPosition!, group[j].yPosition!);
                                });
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(group[j].iconImagePath),
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
                        Get.to(() => MajorDetailView(),
                            arguments: [selectedGroup, ids[selectedIndex ?? 0]]);
                      }
                    },
                    child: DetailCard(group: selectedGroup!),
                  )
              ],
            )
        );
      },
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
                  if (openOrClose) {
                    selectedIndex = index;
                    selectedGroup = groups[index];
                    isGroupClick = true;
                    setTransformation(width, height, groups[index].xPosition!,
                        groups[index].yPosition!);
                    Navigator.pop(context);
                  }
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
