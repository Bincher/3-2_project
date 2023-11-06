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
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    final List<Widget> _widgetOptions = <Widget>[
      AlarmPage(),
    //MySellPostPage(),
    //MyPostPage(),
    //MyPage(),
    ];

    void _onItemTapped(int index) { // 탭을 클릭했을떄 지정한 페이지로 이동
        setState(() {
          _selectedIndex = index;
        });
      }

    final controller = TextEditingController();
    int textCounter = 0;

    _printValue() {
      print("_printValue(): ${controller.text}");
      setState(() {
        textCounter = controller.text.length;
      });
    }

    @override
    void initState() {
      super.initState();
      controller.addListener(_printValue);
    }

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
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
              ),
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Calender'
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Alarm'
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'map'
            ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        )
    );
  }
}

  
