// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
                child: Text(
                  '${snapshot.data}',
                  style: const TextStyle(color: Colors.black, fontSize: 30),
                ),
              );
            }
            return const Center(
              child: Text(
                'waiting',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
