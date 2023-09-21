// ignore_for_file: avoid_print, must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyListWidget());
  }
}

class MyListWidget extends StatefulWidget {
  const MyListWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyListWidgetState();
  }
}

class _MyListWidgetState extends State<MyListWidget> {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Key Test'),
        ),
        body: Column(children: [
          Row(
            children: widgetList,
          ),
          ElevatedButton(onPressed: onChange, child: Text("toggle"))
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
