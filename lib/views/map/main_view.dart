import 'dart:async';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/models/group.dart';
import 'package:untitled/repository/main_repository.dart';
import 'package:untitled/repository/wadpik_admin_repository.dart';
import 'package:untitled/utils/wad_analytics.dart';
import 'package:untitled/views/search_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/place.dart';
import '../components/detail_card.dart';
import '../group_detail_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  static bool isMaster = false;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final MainRepository _mainRepository;
  PageController _pageController = PageController();


  Timer? timer;
  var time = 10;

  int? selectedIndex;
  int? selectedCategory;
  bool isRefresh = true;
  late String imagePath;

  List<Group> groups = [];
  List<Group> categoryGroup = [];
  int size = 0;

  List<BannerModel> listBanners = [
    BannerModel(id: "1", imagePath: 'assets/images/event.png'),
    BannerModel(id: "2", imagePath: 'assets/images/event.png'),
    BannerModel(id: "3", imagePath: 'assets/images/event.png'),
    BannerModel(id: "4", imagePath: 'assets/images/event.png'),
  ];

  late Future myFuture;

  @override
  void initState() {
    _mainRepository = MainRepository();
    WadAnalytics.setUser();
    getAllData();
    bannerTimer();
    super.initState();
  }

  Future<void> bannerTimer() async {
    while (true) {
      await Future.delayed(Duration(seconds: 10)).then((value) {
        if (_pageController.page == 3) {
          _pageController.jumpToPage(0);
        }
        _pageController.nextPage(
            duration: Duration(seconds: 1), curve: Curves.easeInOut);
      });
    }
  }

  Future<void> _launchUrl() async {
    Uri uri = Uri.parse('https://forms.gle/dBVzQ5mB366uhmWPA');
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
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

  getAllData() {
    // myFuture = Future.delayed(Duration(seconds: 0));
    // getInitialData();
    // setAllData(0);
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
    categoryGroup.sort((b, a) => a.openOrClose!.compareTo(b.openOrClose!));
    categoryGroup.sort((a, b) => a.position!.compareTo(b.position!));
    if(selectedCategory == 6) {
      categoryGroup.sort((b, a) => a.position!.compareTo(b.position!));
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
    double width = MediaQuery.of(context).size.width;
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
          appBar: buildAppBar(context),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildMainImage(width),
                    buildCategoryButton(),
                    buildTotalText(),
                    buildListView(),
                    SizedBox(
                      height: 80.0,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl();
                },
                child: buildBottomBanner(width),
              ),
            ],
          ),
        );
      },
    );
  }

  Column buildBottomBanner(double width) {
    return Column(
      children: [
        Spacer(),
        BannerCarousel.fullScreen(
          pageController: _pageController,
          borderRadius: 0.0,
          height: 70.0,
          banners: listBanners,
          animation: false,
          showIndicator: false,
        ),
      ],
    );
  }

  Widget buildMainImage(double widthSize) {
    return Container(
      height: widthSize,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image(
              image: AssetImage(imagePath),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isRefresh) {
                refresh();
                isRefresh = false;
                timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  if (time == 0) {
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
              child: isRefresh
                  ? Icon(Icons.refresh)
                  : Center(
                      child: Text(
                      "${time}",
                      style: TextStyle(fontSize: 15.0),
                    )),
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
              categoryGroup.sort((b, a) => a.openOrClose!.compareTo(b.openOrClose!));
              if(selectedCategory == 6) {
                categoryGroup.sort((b, a) => a.position!.compareTo(b.position!));
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
      child: Row(
        children: [
          Text(
            "총 ${size}개의 부스",
            style: TextStyle(color: Colors.grey),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.7),
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Text(
              "3분마다 업데이트 됩니다!",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categoryGroup.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed('/detail', arguments: [categoryGroup[index], refresh]);
          },
          child: DetailCard(
            group: categoryGroup[index],
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          final imageProvider = AssetImage("assets/images/map/gachon-map.png");
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
            Get.toNamed('/search', arguments: groups);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.search),
          ),
        ),
      ],
      title: GestureDetector(
        child: Container(
          height: 40.0,
          child: Image(
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
