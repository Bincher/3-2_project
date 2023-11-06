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
  final List<Map<String, dynamic>> _alarmList = [
    {"id": 1, "menu": "제육"},
  ];

  List<Map<String, dynamic>> _foundAlarms = [];
  bool _showCompleted = true;

  @override
  initState() {
    _foundAlarms = List.from(_alarmList);
    super.initState();
  }

  void _dialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String newAlarm = "";
        return AlertDialog(
          title: const Text("할 일 입력"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => newAlarm = value,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Map<String, dynamic> newAlarmItem = {
                  "id": _alarmList.length + 1,
                  "menu": newAlarm,
                };

                setState(() {
                  // Add the new work to the list
                  _alarmList.add(newAlarmItem);
                  _foundAlarms.add(newAlarmItem);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm List'),
        actions: [
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
      floatingActionButton: FloatingActionButton(
        onPressed: _dialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
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
                            color: Colors.amberAccent,
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