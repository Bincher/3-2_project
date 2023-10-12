import 'package:flutter/material.dart';

<<<<<<< HEAD
void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text('View Details'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DetailScreen();
              }),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text('Pop!'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
=======
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'First Screen',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Second Screen',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Third Screen',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    const Text(
      'Fourth Screen',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Theme(
                  data: Theme.of(context).copyWith(),
                  child: Container(
                      height: 48.0,
                      alignment: Alignment.center,
                      child: const Text('AppBar Bottom Text')),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/big.jpeg'),
                        fit: BoxFit.fill)),
              ),
              title: const Text('AppBar Title'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add_alert),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {},
                ),
              ]),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //fixed, shifting
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'First',
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Second',
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Third',
                  backgroundColor: Colors.purple),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'Fourth',
                  backgroundColor: Colors.pink)
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {},
                ),
              ],
            ),
          )),
>>>>>>> ade667518108ac374a0d4b5cdb43981abdd5856e
    );
  }
}
