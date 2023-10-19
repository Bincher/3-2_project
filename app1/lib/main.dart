import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyStatefulPage());
  }
}

class MyStatefulPage extends StatefulWidget {
  const MyStatefulPage({super.key});

  @override
  _MyStatefulPageState createState() => _MyStatefulPageState();
}

class _MyStatefulPageState extends State<MyStatefulPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Counter:'),
            Text('$_counter', style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      // FloatingActionButtonWidget을 여기에 배치합니다.
      floatingActionButton: const ExternalFloatingButton(),
    );
  }
}

class ExternalFloatingButton extends StatelessWidget {
  const ExternalFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    // 부모 위젯인 MyHomePage의 상태를 찾습니다.
    final homePageState =
        context.findAncestorStateOfType<_MyStatefulPageState>();

    return FloatingActionButton(
      onPressed: () {
        // 부모 위젯의 _incrementCounter 메서드를 호출하여 카운터를 증가시킵니다.
        homePageState?._incrementCounter();
      },
      tooltip: 'Increment Counter',
      child: const Icon(Icons.add),
    );
  }
}
