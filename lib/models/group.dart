import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/place.dart';

import 'booth.dart';

class Group {
  Group({
    required this.title,
    required this.intro,
    required this.booth,
    required this.place,
    required this.position,
    required this.status,
    this.waiting,
    this.password,
    required this.openOrClose,
    this.menu,
  });

  String? id;
  String? title;
  String? intro;
  int? booth;
  int? place;
  int? position;
  int? status;
  int? waiting;
  String? password;
  int? openOrClose;
  LinkedHashMap<String, dynamic>? menu;

  static List<Group> initialData = [
    Group(title: "과학 동아리", intro: "과학 동아리에요 반가워요", booth: Booth.club.key, place: Place.freedom.key, position: 1, status: 1, openOrClose: 1),
    Group(title: "제빵 푸드트럭", intro: "푸드 트럭입니다. 맛있는 것 밖에 안팔아요", booth: Booth.foodTruck.key, place: Place.stardom.key, position: 1, status: 1, openOrClose: 1),
    Group(title: "김민수 푸드트럭", intro: "푸드 트럭입니다. 맛있는 것 밖에 안팔아요", booth: Booth.foodTruck.key, place: Place.freedom.key, position: 1, status: 1, openOrClose: 1),
  ];

  factory Group.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Group(
      title: data?['title'],
      intro: data?['intro'],
      booth: data?['booth'],
      place: data?['place'],
      position: data?['position'],
      status: data?['status'],
      waiting: data?['waiting'],
      password: data?['password'],
      openOrClose: data?['openOrClose'],
      menu: data?['menu'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "major": title,
      if (intro != null) "intro": intro,
      if (booth != null) "booth": booth,
      if (place != null) "place": place,
      if (position != null) "position": position,
      if (status != null) "status": status,
      if (waiting != null) "waiting": waiting,
      if (password != null) "password": password,
      if (openOrClose != null) "openOrClose": openOrClose,
      if (menu != null) "menu": menu,
    };
  }
}

class Menu {
  Menu({
    required this.name,
    required this.price,
    required this.status,
  });

  String? name;
  int? price;
  int? status;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "status": status,
      };

  factory Menu.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Menu(
      name: data?['name'],
      price: data?['price'],
      status: data?['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (status != null) "status": status,
    };
  }
}
