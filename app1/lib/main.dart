import 'package:flutter/material.dart';

/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Work List',
      home: AlarmListPage(),
    );
  }
}
*/

// 이제 AlarmListPage 클래스를 다른 페이지에서 사용할 수 있습니다.
// 다른 페이지에서 이 클래스를 호출하려면 
// 해당 페이지에 AlarmListPage() 위젯을 추가하면 됩니다.

class AlarmListPage extends StatefulWidget {
  const AlarmListPage({super.key});

  @override
  _AlarmListPageState createState() => _AlarmListPageState();
}

class _AlarmListPageState extends State<AlarmListPage> {
  final List<Map<String, dynamic>> _alarmList = [
    {"id": 1, "menu": "제육"},
  ];

  List<Map<String, dynamic>> _foundAlarms = [];

  final TextEditingController _alarmTextController = TextEditingController();

  @override
  void initState() {
    _foundAlarms = List.from(_alarmList);
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = List.from(_alarmList);
    } else {
      results = _alarmList
          .where((menu) =>
              menu["menu"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundAlarms = results;
    });
  }

  void _addAlarm() {
    final String newAlarm = _alarmTextController.text;
    if (newAlarm.isNotEmpty) {
      final int newId = _alarmList.length + 1;
      final Map<String, dynamic> newAlarmItem = {"id": newId, "menu": newAlarm};
      setState(() {
        _alarmList.add(newAlarmItem);
        _foundAlarms.add(newAlarmItem);
      });
      // Clear the text field after adding an alarm
      _alarmTextController.clear();
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
                  onPressed: _addAlarm,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: '검색', suffixIcon: Icon(Icons.search)),
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
                                      setState(
                                        () {
                                          _foundAlarms.remove(alarm);
                                          _alarmList.remove(alarm);
                                        },
                                      );
                                    })));
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
