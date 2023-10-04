// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Test'),
            ),
            body: const TestScreen()));
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(),
        Text('Form Test'),
        SizedBox(height: 20),
        Text('Form Test'),
        SizedBox(height: 40),
        Text('Form Test'),
        Spacer(),
      ],
    );
  }
}
