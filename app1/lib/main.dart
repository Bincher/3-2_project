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
      title: 'Work List',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 작업 목록을 저장하는 리스트
  final List<Map<String, dynamic>> _workList = [
    {"id": 1, "work": "10/17 소프트웨어공학 과제2", "isChecked": true},
    {"id": 2, "work": "10/19 오픈소스프로젝트 과제2", "isChecked": false},
    {"id": 3, "work": "10/30 과학기술영어독해 어휘과제1", "isChecked": false},
  ];

  List<Map<String, dynamic>> _foundWorks = [];
  bool _showCompleted = true; // 완료된 작업을 보여주는 토글 변수

  @override
  initState() {
    _foundWorks = List.from(_workList); // 처음에는 모든 작업을 보여줍니다.
    super.initState();
  }

  // 새 작업을 추가하는 다이얼로그를 열기 위한 함수
  void _dialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String newWork = "";
        return AlertDialog(
          title: const Text("할 일 입력"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newWork = value,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 새로운 작업을 입력받아 목록에 추가합니다.
                Map<String, dynamic> newWorkItem = {
                  "id": _workList.length + 1,
                  "work": newWork,
                  "isChecked": false,
                };

                setState(() {
                  _workList.add(newWorkItem);
                  _foundWorks.add(newWorkItem);
                });

                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  // 작업 목록을 검색하는 함수
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = List.from(_workList); // 검색어가 비어있을 때 모든 작업을 보여줍니다.
    } else {
      results = _workList
          .where((work) =>
              work["work"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundWorks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work List'),
        actions: [
          // 완료된 작업을 보여주는 토글 버튼
          IconButton(
            icon: Icon(_showCompleted ? Icons.check : Icons.clear),
            onPressed: () {
              setState(() {
                _showCompleted = !_showCompleted;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            // 새 작업을 추가하는 FAB
            FloatingActionButton(
              onPressed: _dialog,
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),
            // 작업 목록 검색 필드
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundWorks.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundWorks.length,
                      itemBuilder: (context, index) {
                        final work = _foundWorks[index];
                        // 완료된 작업을 보여주지 않음
                        if (!_showCompleted && work["isChecked"]) {
                          return const SizedBox.shrink();
                        }
                        return Card(
                            key: ValueKey(work["id"]),
                            color: Colors.amberAccent,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                                leading: Checkbox(
                                  value: work["isChecked"],
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      work["isChecked"] = newValue;
                                    });
                                  },
                                ),
                                title: Text(
                                  work['work'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    decoration: work["isChecked"]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _foundWorks.remove(work);
                                          _workList.remove(work);
                                        },
                                      );
                                    })));
                      })
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
