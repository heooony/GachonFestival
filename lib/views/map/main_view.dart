import 'dart:async';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/models/group.dart';
import 'package:untitled/repository/main_repository.dart';
import 'package:untitled/views/search_view.dart';
import '../../models/place.dart';
import '../components/detail_card.dart';
import '../group_detail_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TransformationController transformationController =
      TransformationController();
  late final MainRepository _mainRepository;

  Timer? timer;
  var time = 10;

  int? selectedIndex;
  int? selectedCategory;
  bool isRefresh = true;
  late String imagePath;

  List<Group> groups = [];
  List<Group> categoryGroup = [];
  int size = 0;

  late Future myFuture;

  @override
  void initState() {
    _mainRepository = MainRepository();
    setInitialTransformation();
    getAllData();
    super.initState();
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 0));
    groups = [];
    categoryGroup = [];
    setState(() {
      myFuture = _mainRepository.getData(groups).then((value) {
        getInitialData();
        setAllData(selectedCategory!);
      });
    });
  }

  void setInitialTransformation() {
    final zoomFactor = 0.7;
    transformationController.value.setEntry(0, 0, zoomFactor);
    transformationController.value.setEntry(1, 1, zoomFactor);
    transformationController.value.setEntry(2, 2, zoomFactor);
    transformationController.value.setEntry(0, 3, 0.0);
    transformationController.value.setEntry(1, 3, 0.0);
  }

  getAllData() {
    myFuture = _mainRepository.getData(groups).then((value) {
      getInitialData();
      setAllData(0);
    });
  }

  getInitialData() {
    groups.addAll(Group.initialData);
  }

  setAllData(int selectNum) {
    selectedCategory = selectNum;
    imagePath = Place.values.elementAt(selectedCategory!).image;
    for (var group in groups) {
      if (group.place == selectedCategory) {
        categoryGroup.add(group);
      }
    }
    size = categoryGroup.length;
  }

  setImagePath() {
    for (Place num in Place.values) {
      if (num.key == selectedCategory) {
        imagePath = num.image;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Text(
              "로드중",
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          );
        }
        if (snapshot.hasError) {
          return Container();
        }
        return Scaffold(
          appBar: buildAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildMainImage(),
              buildCategoryButton(),
              buildTotalText(),
              buildListView(),
            ],
          ),
        );
      },
    );
  }

  Container buildMainImage() {
    return Container(
      height: 270.0.h,
      child: Stack(
        children: [
          InteractiveViewer(
            transformationController: transformationController,
            minScale: 0.5,
            constrained: false,
            child: Center(
              child: Image(
                image: AssetImage(imagePath),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if(isRefresh) {
                refresh();
                isRefresh = false;
                timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  if(time == 0) {
                    timer.cancel();
                    isRefresh = true;
                    time = 10;
                  }
                  setState(() {
                    time--;
                  });
                });
              }
            },
            child: Container(
              width: 45.0,
              height: 45.0,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 11,
                        spreadRadius: 0)
                  ]),
              child: isRefresh ? Icon(Icons.refresh) : Center(child: Text("${time}", style: TextStyle(fontSize: 15.0),)),
            ),
          ),
        ],
      ),
    );
  }

  GridView buildCategoryButton() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: Place.values.length,
      padding: EdgeInsets.all(10.0),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        mainAxisExtent: 30.0,
        crossAxisCount: 4,
        childAspectRatio: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        bool isSelect = (index == selectedCategory);
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = index;
              categoryGroup = [];
              for (var group in groups) {
                if (group.place == selectedCategory) {
                  categoryGroup.add(group);
                }
              }
              size = categoryGroup.length;
              setImagePath();
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: isSelect ? Colors.indigo : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                border: isSelect
                    ? null
                    : Border.all(color: Colors.black, width: 0.5)),
            child: Center(
              child: Text(
                Place.values.elementAt(index).name,
                style: TextStyle(
                  color: isSelect ? Colors.white : Colors.black,
                  fontWeight: isSelect ? FontWeight.w500 : FontWeight.w300,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Padding buildTotalText() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Text(
        "총 ${size}개의 부스",
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Expanded buildListView() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categoryGroup.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => GroupDetailView(callback: refresh), arguments: categoryGroup[index]);
            },
            child: DetailCard(
              group: categoryGroup[index],
            ),
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          final imageProvider =
              Image.asset("assets/images/map/gachon-map.png").image;
          showImageViewer(context, imageProvider, useSafeArea: true);
        },
        child: Icon(
          Icons.map_sharp,
          color: Colors.black.withOpacity(0.8),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => SearchView(), arguments: groups);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.search),
          ),
        ),
      ],
      title: Text(
        'WadPik',
        style: TextStyle(fontSize: 25.0),
      ),
    );
  }
}
