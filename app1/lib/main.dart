// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<int> delay() {
    return Future<int>(() async {
      var msec = 2000;
      await Future.delayed(Duration(milliseconds: msec));
      return msec;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
        ),
        body: FutureBuilder(
          future: delay(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: defaultText('${snapshot.data}')
              );
            }
            return const Center(
              child: defaultText("wating"),
            );
          },
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class defaultText extends StatelessWidget {
  final String string;
  const defaultText(
    this.string,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      style: const TextStyle(color: Colors.black, fontSize: 30),
    );
  }
}
