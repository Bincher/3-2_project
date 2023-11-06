import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '어플리케이션',
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int _selectedIndex = 0;

  final List<Widget> _navIndex = [
    const CalenderPage(),
    const AlarmListPage(),
    const LocationPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navIndex.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '식단 캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: '알람설정',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '식당 위치 및 정보',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
      )
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('식당 위치'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildLocationCard(
                "학생회관 지하 1층\n휴무일: 주말, 공휴일",
                'images/img_skyview.png',
              ),
              _buildLocationCard(
                "학식당,교직원식당 입구\n08:20~09:20/11:30~13:30/17:00~18:30",
                'images/img_cafeteria_outout.jpg',
              ),
              _buildLocationCard(
                "분식당 입구\n11:00~14:00/16:00~18:30",
                'images/img_cafeteria_out1.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard(String locationName, String imagePath) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16/9, // 이미지의 가로 세로 비율을 조정할 수 있음
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(locationName),
          ),
        ],
      ),
    );
  }
}

class AlarmListPage extends StatefulWidget {
  const AlarmListPage({Key? key}) : super(key: key);

  @override
  _AlarmListPageState createState() => _AlarmListPageState();
}

class _AlarmListPageState extends State<AlarmListPage> {
  // 알람 목록과 필터된 알람 목록을 저장하는 리스트
  final List<Map<String, dynamic>> _alarmList = [
    {"id": 1, "menu": "제육"},
  ];

  List<Map<String, dynamic>> _foundAlarms = [];
  // 사용자로부터 텍스트 입력을 받는 컨트롤러
  final TextEditingController _alarmTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _foundAlarms = List.from(_alarmList);
  }

  // 키워드에 따라 알람 필터링
  void _runFilter(String enteredKeyword) {
    setState(() {
      if (enteredKeyword.isEmpty) {
        // 키워드가 비어있으면 원래 알람 목록을 표시
        _foundAlarms = List.from(_alarmList);
      } else {
        // 키워드가 있는 경우 해당 키워드를 포함하는 알람 필터링
        _foundAlarms = _alarmList
            .where((menu) =>
                menu["menu"].toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      }
    });
  }

  // 새로운 알람 추가
  void _addAlarm() {
    final String newAlarm = _alarmTextController.text;
    if (newAlarm.isNotEmpty) {
      final int newId = _alarmList.length + 1;
      final Map<String, dynamic> newAlarmItem = {"id": newId, "menu": newAlarm};
      setState(() {
        // 알람 목록에 새 알람 추가
        _alarmList.add(newAlarmItem);
        // 필터된 알람 목록에도 추가하여 표시
        _foundAlarms.add(newAlarmItem);
        // 텍스트 필드 지우기
        _alarmTextController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알람 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text(
              "선호 메뉴 추가",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            TextField(
              controller: _alarmTextController,
              decoration: InputDecoration(
                labelText: '선호 메뉴',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addAlarm, // 알람 추가 버튼 클릭 시 _addAlarm 함수 호출
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value), // 텍스트 필터링
              decoration: const InputDecoration(
                labelText: '검색',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "<아래 메뉴가 있는 날에는 알람이 전송됩니다>",
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundAlarms.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundAlarms.length,
                      itemBuilder: (context, index) {
                        final alarm = _foundAlarms[index];
                        return Card(
                          key: ValueKey(alarm["id"]),
                          color: Colors.blue[100],
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(
                              alarm['menu'],
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  // 알람 삭제 버튼 클릭 시 _foundAlarms 및 _alarmList에서 제거
                                  _foundAlarms.remove(alarm);
                                  _alarmList.remove(alarm);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Text(
                      '추가한 메뉴가 없어요 :(\n좋아하는 메뉴를 추가해주세요',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => CalenderPageState();
}

class CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('캘린더 식단'),
      ),
      body: const Center(
        child: Text(
          '캘린더 기능',
        ),
      ),
    );
  }
}