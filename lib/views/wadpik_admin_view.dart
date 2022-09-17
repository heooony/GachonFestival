// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/repository/wadpik_admin_repository.dart';
//
// import '../models/group.dart';
//
// class WadPikAdminView extends StatefulWidget {
//   const WadPikAdminView({Key? key}) : super(key: key);
//
//   @override
//   State<WadPikAdminView> createState() => _WadPikAdminViewState();
// }
//
// class _WadPikAdminViewState extends State<WadPikAdminView> {
//   late final WadpikAdminRepository _repository;
//   late final Future futureData;
//   List<Group> groups = [];
//   List<String> ids = [];
//   List<String> changeIds = [];
//   List<int> changeIndex = [];
//
//   @override
//   void initState() {
//     _repository = WadpikAdminRepository();
//     futureData = _repository.getData(majors, ids);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: FutureBuilder(
//           future: futureData,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return Column(
//               children: [
//                 for (int i = 0; i < majors.length; i++)
//                   Container(
//                     padding: EdgeInsets.all(20.0),
//                     width: double.infinity,
//                     child: Row(
//                       children: [
//                         Text(
//                           majors[i].title!,
//                           style: TextStyle(fontSize: 23.0),
//                         ),
//                         Spacer(),
//                         Row(
//                           children: [
//                             buildGestureDetector(i, "원활", 0, ids[i]),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                             buildGestureDetector(i, "보통", 1, ids[i]),
//                             SizedBox(
//                               width: 5.0,
//                             ),
//                             buildGestureDetector(i, "혼잡", 2, ids[i]),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ElevatedButton(
//                     onPressed: () {
//                       for (int i = 0; i < changeIds.length; i++) {
//                         FirebaseFirestore.instance
//                             .collection('majors')
//                             .doc(changeIds[i])
//                             .update({
//                           'status': majors[changeIndex[i]].status
//                         }).then((value) => print("clear!"));
//                       }
//
//                       changeIds.clear();
//                     },
//                     child: Text("저장"))
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   GestureDetector buildGestureDetector(
//       int i, String name, int status, String id) {
//     return GestureDetector(
//       onTap: () {
//         if (!changeIds.contains(id) && !changeIndex.contains(i)) {
//           changeIds.add(id);
//           changeIndex.add(i);
//         }
//         setState(() {
//           majors[i].status = status;
//         });
//       },
//       child: Container(
//         child: Text(
//           name,
//           style: TextStyle(
//             color: majors[i].status == status ? Colors.white : Colors.black,
//             fontSize: 20.0,
//           ),
//         ),
//         decoration: BoxDecoration(
//             color: majors[i].status == status ? Colors.black : Colors.white),
//       ),
//     );
//   }
// }
