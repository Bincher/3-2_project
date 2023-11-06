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
      title: 'Alarm Setting',
      home: AlarmPage(),
    );
    
  }
}

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final controller = TextEditingController();
  int textCounter = 0;
  String savedWord = "";
  final List<Map<String, dynamic>> _alarmList = [
    {"id": 1, "menu": "제육"},
  ];
  List<Map<String, dynamic>> _foundAlarms = [];

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = List.from(_alarmList);
    } else {
      results = _alarmList
          .where((work) =>
              work["work"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundAlarms = results;
    });
  }

    @override
    void initState() {
      super.initState();
      _foundAlarms = List.from(_alarmList);
    }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    void _saveWord() {
      setState(() {
        savedWord = controller.text;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('TextField Test'),
            TextField(
              style: const TextStyle(fontSize: 15.0),
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Data',
                prefixIcon: const Icon(Icons.input),
                border: const OutlineInputBorder(),
                hintText: "Hint Text",
                helperText: "데이터를 입력하세요.",
                counterText: "$textCounter characters",
              ),
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.emailAddress,
              minLines: 5,
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  textCounter = value.length;
                });
              },
            ),
            TextButton(
              onPressed: () {
                Map<String, dynamic> newAlarmItem = {
                  "id": _alarmList.length + 1,
                  "work": controller.text,
                };

                setState(() {
                  // Add the new work to the list
                  _alarmList.add(newAlarmItem);
                  _foundAlarms.add(newAlarmItem);
                });
                Navigator.of(context).pop();
              },
              child: const Text("추가"),
            ),
            Expanded(
              child: _foundAlarms.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundAlarms.length,
                      itemBuilder: (context, index) {
                        final menu = _foundAlarms[index];
                        return Card(
                            key: ValueKey(menu["id"]),
                            color: Colors.amberAccent,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                                title: Text(
                                  menu['work'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(
                                        () {
                                          _foundAlarms.remove(menu);
                                          _alarmList.remove(menu);
                                        },
                                      );
                                    })));
                      })
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
        )]
        )
      )
    );
  }
}

  
