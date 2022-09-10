import 'package:flutter/material.dart';
import 'package:untitled/models/major.dart';

class DataInputView extends StatefulWidget {
  const DataInputView({Key? key}) : super(key: key);

  @override
  State<DataInputView> createState() => _DataInputViewState();
}

class _DataInputViewState extends State<DataInputView> {
  TextEditingController menuCountController = TextEditingController();
  int menuCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(hintText: "학과"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "설명"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "1: open, 0: close"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "암호(대체로 4자)"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "0: 원활, 1: 보통, 2: 혼잡"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "x 좌표"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "y 좌표"),
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "메뉴 수"),
                  onFieldSubmitted: (val) {
                    try {
                      setState(() {
                        menuCount = int.parse(val);
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                for (int i = 0; i < menuCount; i++)
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: "메뉴 이름"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "가격"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "설명"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "상태(고정: 1)"),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("취소"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 20.0))),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Major major = Major(intro: intro, major: major, menu: menu, openOrClose: openOrClose, password: password, status: status, xPosition: xPosition, yPosition: yPosition)
                      },
                      child: Text("저장"),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
