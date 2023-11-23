// snack_bar_menu.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'menu_fetcher.dart';
import 'menu_display_widget.dart'; // Update with the correct import path
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListWidget3(selectedDate: DateTime.now()),
      theme: ThemeData(
        // your theme data here
      ),
    );
  }
}

class MyListWidget3 extends StatefulWidget {
  final DateTime selectedDate;

  const MyListWidget3({super.key, required this.selectedDate});

  @override
  State<StatefulWidget> createState() {
    return _MyListWidgetState();
  }
}

class _MyListWidgetState extends State<MyListWidget3> {
  Map<String, dynamic> menuData = {'menuLines': ["로딩 중..."], 'selectedLocation': "snack", 'time': "."};
  List<Map<String, dynamic>> menuList = [];
  static const maxMenuListLength = 5;

  @override
  void initState() {
    super.initState();
    
    print("현재 menuList: $menuList");
    fetchMenuData();
    }
  

  Future<int> loadMenuList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? menuListString = prefs.getString('menuList');
    if (menuListString != null) {
      setState(() {
        menuList = List<Map<String, dynamic>>.from(json.decode(menuListString));
      });
    }
    return 1;
  }
  
  void saveMenuList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('menuList', json.encode(menuList));
    if (menuList.length > maxMenuListLength) {
      clearAllMenuData(prefs);
    }
    print("업데이트된 menuList: $menuList");
  }
  

  void clearAllMenuData(SharedPreferences prefs) {
    prefs.remove('menuList');
    menuList.clear();
  }
  
  void fetchMenuData() async {
    try {
      await loadMenuList();
      bool hasData = menuList.any((item) =>
        item['selectedDate'] == DateFormat('MM-dd').format(widget.selectedDate));
      print(hasData);

    // 데이터가 없으면 추가
      if (!hasData) {
        final data = await MenuFetcher.fetchMenuDataFromFirestore(widget.selectedDate);
        print("Fetched menu data: $data");
  
        saveMenuList(); // 변경된 menuList를 저장

        setState(() {
          menuList.add(data);
          menuData = data;
        });
        
      } else {
        print("이미 해당 날짜의 데이터가 추가되어 있습니다.");
        final data = menuList.firstWhere(
          (menuData) => menuData['selectedDate'] == DateFormat('MM-dd').format(widget.selectedDate)
        );
        setState(() {
          menuData = data;
        });

      }
      } catch (e) {
        // 에러 발생 시 에러를 추가
        setState(() {
          menuList.add({'error': '오류: $e'});
          menuData = {'error': '오류: $e'};
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(
          title: const Text('분식당'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
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
          const SizedBox(height: 20.0),
          const Divider(
            color: Colors.brown,
            thickness: 3.0,
          ),
          const SizedBox(height: 20.0),
          MenuDisplayWidget(menuData: menuData),
        ],
      ),
    );
  }
}