import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/major_detail.dart';
import 'package:untitled/model/major.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final TransformationController transformationController =
      TransformationController();

  bool isMajorClick = false;
  int? selectedIndex;
  double scale = 1.0;
  List<Major> majors = [];

  void getData() async {
    final ref = FirebaseFirestore.instance.collection('majors').withConverter(
        fromFirestore: Major.fromFirestore,
        toFirestore: (Major major, _) => major.toFirestore());
    final docSnap = await ref.get();
    docSnap.docs.map((e) {
      majors.add(e.data());
    }).toList();
    print(majors[0].menu);
  }

  @override
  void initState() {
    super.initState();
    getData();
    transformationController.value = Matrix4.identity()
      ..translate(-2400.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text('가천대 지도 & 혼잡도 확인'),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: majors.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(
                  majors[index].major!,
                ),
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    isMajorClick = true;
                    Navigator.pop(context);
                  });
                });
          },
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
                      isMajorClick = false;
                    });
                  },
                  child: Image(
                    image: AssetImage("assets/images/gachon_map.png"),
                  ),
                ),
                for (int i = 0; i < majors.length; i++)
                  Positioned(
                    left: majors[i].xPosition,
                    top: majors[i].yPosition,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMajorClick = !isMajorClick;
                          selectedIndex = i;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/location-pin.png"),
                        )),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!isMajorClick)
            Container()
          else
            GestureDetector(
              onTap: () {
                Get.to(() => MajorDetailView(), arguments: majors[selectedIndex ?? 0]);
              },
              child: detailMajorBox(
                major: majors[selectedIndex ?? 0].major,
                intro: majors[selectedIndex ?? 0].intro,
                status: majors[selectedIndex ?? 0].status,
                openOrClose: majors[selectedIndex ?? 0].openOrClose,
              ),
            )
        ],
      ),
    );
  }
}

class detailMajorBox extends StatelessWidget {
  detailMajorBox({
    required this.major,
    required this.intro,
    required this.status,
    required this.openOrClose,
  });

  final major;
  final intro;
  final status;
  final openOrClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Container(
          width: double.infinity,
          height: 190,
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 0),
                    blurRadius: 11,
                    spreadRadius: 0)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    major,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 14.0,
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 14,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  Text("13",
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.7))),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      intro,
                      maxLines: 3,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: statusColorBrain(status),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text(
                        statusTextBrain(status),
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color statusColorBrain(int status) {
    if (status == 0) return Colors.green;
    else if (status == 1) return Colors.amber;
    else if (status == 2) return Colors.red;
    else return Colors.white;
  }

  String statusTextBrain(int status) {
    if (status == 0) return "원활";
    else if (status == 1) return "보통";
    else if (status == 2) return "혼잡";
    else return "모름";
  }
}
