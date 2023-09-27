// ignore_for_file: avoid_print, must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyTestWidget());
  }
}

class MyTestWidget extends StatefulWidget {
  const MyTestWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyTestWidgetState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                  Container(
                    width: 50,
                    height: 150,
                    color: Colors.blue,
                  ),
                ],
              )),
          Container(
              color: Colors.yellow,
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                  Container(
                    width: 50,
                    height: 150,
                    color: Colors.blue,
                  ),
                ],
              )),
          Container(
              color: Colors.yellow,
              margin: EdgeInsets.only(bottom: 5),
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                  Container(
                    width: 50,
                    height: 150,
                    color: Colors.blue,
                  ),
                ],
              )),
          Container(
            color: Colors.yellow,
            margin: EdgeInsets.only(bottom: 5),
            height: 200,
            child: Stack(
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.yellow,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyTestWidgetState extends State<MyTestWidget> {
  List<Widget> widgetList = [
    // UniqueKey()뒤 ,의 여부따라 저장시 라인수가 달라짐
    MyColorItemWidget(
      Colors.red,
      key: UniqueKey(),
    ),
    MyColorItemWidget(Colors.blue, key: UniqueKey()),
    // UniqueKey()를 지우면 제대로된 동작이 불가능
  ];
  onChange() {
    print(widgetList.elementAt(0).key);
    setState(() {
      widgetList.insert(1, widgetList.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold라는 이름의 객체를 생성, new Scaffold
    return Scaffold(
        appBar: AppBar(
          title: const Text('Key Test'),
        ),
        body: Column(children: [
          Row(
            children: widgetList,
          ),
          ElevatedButton(onPressed: onChange, child: const Text("toggle"))
        ]));
  }
}

class MyColorItemWidget extends StatefulWidget {
  Color color;
  MyColorItemWidget(this.color, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyColorItemWidgetState(color);
  }
}

class _MyColorItemWidgetState extends State<MyColorItemWidget> {
  Color color;
  _MyColorItemWidgetState(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: color,
      width: 150,
      height: 150,
    ));
  }
}
