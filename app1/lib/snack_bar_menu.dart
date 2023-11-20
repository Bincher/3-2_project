import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListWidget3(selectedDate: DateTime.now()),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          toolbarTextStyle: TextTheme(
            headline6: TextStyle(
              color: Colors.brown,
              fontSize: 10.0,
            ),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline6: TextStyle(
              color: Colors.brown,
              fontSize: 25.0,
            ),
          ).headline6,
        ),
      ),
    );
  }
}

class MyListWidget3 extends StatefulWidget {
  final DateTime selectedDate;

  MyListWidget3({required this.selectedDate,});

  @override
  State<StatefulWidget> createState() {
    return _MyListWidgetState();
  }
}

class _MyListWidgetState extends State<MyListWidget3> {
  String foodData = "로딩 중..."; // 컨테이너 데이터

  @override
  void initState() {
    super.initState();
    fetchMenuData();
  }

  void fetchMenuData() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.kumoh.ac.kr/ko/restaurant04.do?mode=menuList&srDt=${DateFormat('yyyy').format(widget.selectedDate)}-${DateFormat('MM').format(widget.selectedDate)}-${DateFormat('dd').format(widget.selectedDate)}'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
        },
      );

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final foodElements = document.querySelectorAll(".menu-list-box table tbody tr:nth-child(1) td:nth-child(${widget.selectedDate.weekday * 2 - 1})");

        if (foodElements.isNotEmpty) {
          final foodMenu = foodElements[0].text;
          final modifiedFoodMenu = foodMenu.replaceAll(RegExp(r'\s{2,}'), '\n');
          List<String> foodMenuLines = modifiedFoodMenu.split('\n');
          foodMenuLines.removeWhere((element) => element.trim().isEmpty);

          Map<String, dynamic> jsonData = {
            'menuLines': foodMenuLines,
            'selectedDate': DateFormat('MM-dd').format(widget.selectedDate),
            'selectedLocation': "snack",
            'time': "."
          };
          String jsonString = jsonEncode(jsonData);
          print(jsonString);
          setState(() {
            foodData = modifiedFoodMenu;
          });
        } else {
          setState(() {
            foodData = "데이터가 존재하지 않습니다.";
          });
        }
      } else {
        setState(() {
          foodData = "데이터를 가져오는 중 오류가 발생했습니다. Response code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        foodData = "오류: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          title: Text('분식당'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.brown,
              ),
              onPressed: () {
                // 닫기 버튼을 눌렀을 때 수행할 동작
                // 여기에 원하는 동작을 추가할 수 있습니다.
              },
            )
          ],
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Divider(
            color: Colors.brown,
            thickness: 3.0,
          ),
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.brown,
                width: 2.0,
              ),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      foodData, // 데이터 렌더링 추가
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "부대찌개: 7000원\n치즈부대찌개: 7000원\n가라아게덮밥: 6500원\n라면류: 2000원~3500원\n돈까스류: 4000원~4200원",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
