import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Major {
  Major({
    required this.intro,
    required this.major,
    required this.menu,
    required this.openOrClose,
    required this.password,
    required this.status,
    required this.xPosition,
    required this.yPosition
  });

  String? intro;
  String? major;
  LinkedHashMap<String, dynamic> menu;
  int? openOrClose;
  String? password;
  int? status;
  double? xPosition;
  double? yPosition;

  factory Major.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Major(
      intro: data?['intro'],
      major: data?['major'],
      menu: data?['menu'],
      openOrClose: data?['openOrClose'],
      password: data?['password'],
      status: data?['status'],
      xPosition: data?['xPosition'],
      yPosition: data?['yPosition']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (intro != null) "intro": intro,
      if (major != null) "major": major,
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
