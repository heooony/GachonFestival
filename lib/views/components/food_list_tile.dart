import 'dart:collection';

import 'package:flutter/material.dart';

class FoodListTile extends StatelessWidget {
  FoodListTile({required this.menu});

  LinkedHashMap<String, dynamic> menu;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (menu['status'] == 0)
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.grey. withOpacity(0.2)),
                    child: Center(
                      child: Text(
                        "매진",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,)
                ],
              ),
            Text(
              menu['name'],
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: menu['status'] == 1 ? Colors.black : Colors.grey),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "${menu['price']}원",
              style: TextStyle(
                  fontSize: 15.0,
                  color: menu['status'] == 1 ? Colors.black : Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          menu['content'] ?? "",
          style: TextStyle(
              fontSize: 15,
              color: menu['status'] == 1
                  ? Colors.grey
                  : Colors.grey.withOpacity(0.5)),
        )
      ],
    );
  }
}
