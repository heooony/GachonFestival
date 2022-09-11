import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'group.dart';

class Major extends Group {
  Major(
      {required this.intro,
      required this.title,
      required this.menu,
      required this.openOrClose,
      required this.likes,
      required this.password,
      required this.status,
      required this.xPosition,
      required this.yPosition})
      : super(title, intro, openOrClose, xPosition, yPosition);

  String? intro;
  String? title;
  LinkedHashMap<String, dynamic> menu;
  int? openOrClose;
  int? likes;
  String? password;
  int? status;
  double? xPosition;
  double? yPosition;
  String iconImagePath = "assets/images/major-pin.png";

  factory Major.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Major(
        intro: data?['intro'],
        title: data?['title'],
        menu: data?['menu'],
        openOrClose: data?['openOrClose'],
        likes: data?['likes'],
        password: data?['password'],
        status: data?['status'],
        xPosition: data?['xPosition'],
        yPosition: data?['yPosition']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (intro != null) "intro": intro,
      if (title != null) "major": title,
      if (menu != null) "menus": menu,
      if (openOrClose != null) "openOrClose": openOrClose,
      if (password != null) "password": password,
      if (status != null) "status": status,
      if (xPosition != null) "xPosition": xPosition,
      if (yPosition != null) "yPosition": yPosition,
    };
  }
}

class Menu {
  Menu({
    required this.name,
    required this.price,
    required this.content,
    required this.status,
  });

  String? name;
  int? price;
  String? content;
  int? status;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
        price: json["price"],
        content: json["content"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "content": content,
        "status": status,
      };

  factory Menu.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Menu(
      name: data?['name'],
      price: data?['price'],
      content: data?['content'],
      status: data?['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (content != null) "content": content,
      if (status != null) "status": status,
    };
  }
}
