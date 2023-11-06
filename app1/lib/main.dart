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
      title: '알람 설정',
      home: AlarmListPage(), // 알람 설정 페이지를 애플리케이션의 홈으로 설정
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
