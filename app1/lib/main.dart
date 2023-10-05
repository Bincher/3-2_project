import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page View"),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              page.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linearToEaseOut,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              page.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linearToEaseOut,
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: page,
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        children: [
          Container(
            color: Colors.deepOrange,
            child: const Center(
                child: Text(
              "Page-1",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
          Container(
            color: Colors.grey,
            child: const Center(
                child: Text(
              "Page-2",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
          Container(
            color: Colors.teal,
            child: const Center(
                child: Text(
              "Page-3",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
          Container(
            color: Colors.green,
            child: const Center(
                child: Text(
              "Page-4",
              style: TextStyle(color: Colors.white, fontSize: 25),
            )),
          ),
        ],
      ),
    );
  }
}
