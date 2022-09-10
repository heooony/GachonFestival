import 'dart:collection';

import 'package:flutter/material.dart';

class AdminFoodListTile extends StatefulWidget {
  AdminFoodListTile({required this.menu});

  LinkedHashMap<String, dynamic> menu;

  @override
  State<AdminFoodListTile> createState() => _AdminFoodListTileState();
}

class _AdminFoodListTileState extends State<AdminFoodListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.menu['name'],
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "${widget.menu['price']}원",
                    style: TextStyle(fontSize: 15.0),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                widget.menu['content'] ?? "",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              )
            ],
          ),
        ),
        Checkbox(
          value: soldOutBrain(widget.menu['status']),
          onChanged: (value) {
            setState(() {
              widget.menu['status'] = soldOutBrainInt(value!);
            });
          },
        )
      ],
    );
  }

  bool soldOutBrain(int status) {
    if (status == 1)
      return true;
    else
      return false;
  }

  int soldOutBrainInt(bool status) {
    if (status) return 1;
    else return 0;
  }
}
