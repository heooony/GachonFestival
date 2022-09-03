import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:untitled/major_list.dart';
import 'dart:typed_data';
import 'package:custom_map_markers/custom_map_markers.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final LatLng _center = const LatLng(37.454827, 127.135008);
  late GoogleMapController mapController;
  String title = "마커를 클릭해주세요";
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> _markers = [];
  late CollectionReference majorsStream;
  late var allList;

  Future<void> setData() async {
    QuerySnapshot querySnapshot = await majorsStream.get();
    querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      if(data['lat'] != null && data['lang'] != null) {
        _markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(double.parse(data['lat']), double.parse(data['lang'])),
            onTap: () {
              setState(() {
                title = data['name'];
                LatLng newlatlang = LatLng(double.parse(data['lat']), double.parse(data['lang']));
                mapController?.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: newlatlang, zoom: 20)
                ));
              });
            },
          ),
        );
      }
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    majorsStream = FirebaseFirestore.instance.collection('majors');
    setData();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: Text('가천대 지도 & 혼잡도 확인'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => MajorListView());
            },
            icon: Icon(Icons.list_alt_sharp),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => MajorListView());
            },
            icon: Icon(Icons.settings_sharp),
          ),
        ],
        leadingWidth: 0.0,
        iconTheme: IconThemeData(size: 30.0),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            markers: Set.from(_markers),
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
          ),

          Container(
            width: double.infinity,
            height: 150,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 40.0),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
