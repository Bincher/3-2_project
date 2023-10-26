import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> menuLines = [];

  @override
  void initState() {
    super.initState();
    fetchMenuData();
  }

  Future<void> fetchMenuData() async {
    final response = await http.get(Uri.parse("https://www.kumoh.ac.kr/ko/restaurant01.do"));

    final document = parse(response.body);

    // 메뉴 정보를 가져오는 CSS 선택자를 지정합니다.
    final menuElement = document.querySelector(".menu-list-box table tbody tr:nth-child(1) td:nth-child(1)");

    if (menuElement != null) {
      // 선택된 요소에서 텍스트를 추출합니다.
      final menuText = menuElement.text;

      // 텍스트를 문장으로 분할하고 리스트에 추가합니다.
      final lines = menuText.split('\n');
      setState(() {
        menuLines = lines;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(menuLines[13]),
        ),
        body: Center(
          child: Column(
            children: menuLines.map((line) => Text(line)).toList(),
          ),
          
        ),
      ),
    );
  }
}
