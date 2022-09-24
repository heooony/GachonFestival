import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/group.dart';
import '../models/group.dart';
import 'components/detail_card.dart';
import 'group_detail_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  List<Group> groups = Get.arguments;
  List<Group> matchQuery = [];
  int length = 0;
  String text = "";

  void callback() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        title: TextFormField(
          onChanged: (val) {
            setState(() {
              text = val;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            labelStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
            labelText: 'Search...',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Text(
                  "담당자 전화번호 : 010-4195-1459",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Text(
                  "${text}의 검색 결과",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(child: buildListView()),
        ],
      ),
    );
  }

  ListView buildListView() {
    matchQuery = [];
    for (Group group in groups) {
      if (group.title!.contains(text)) {
        matchQuery.add(group);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed('/detail', arguments: [matchQuery[index], callback]);
          },
          child: DetailCard(
            group: matchQuery[index],
          ),
        );
      },
    );
  }
}
