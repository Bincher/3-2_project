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
      title: 'Location',
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('식당 위치'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _buildLocationCard(
                "학생회관 지하 1층\n휴무일: 주말, 공휴일",
                'images/img_skyview.png',
              ),
              _buildLocationCard(
                "학식당,교직원식당 입구\n08:20~09:20/11:30~13:30/17:00~18:30",
                'images/img_cafeteria_outout.jpg',
              ),
              _buildLocationCard(
                "분식당 입구\n11:00~14:00/16:00~18:30",
                'images/img_cafeteria_out1.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard(String locationName, String imagePath) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        AspectRatio(
          aspectRatio: 16/9, // 가로 세로 비율을 조정할 수 있음
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        ListTile(
          title: Text(locationName),
        ),
      ],
    ),
  );
}
}
