import 'package:diem/constants/constants.dart';
import 'package:diem/screens/home_page.dart';
import 'package:diem/screens/map_page.dart';
import 'package:diem/screens/people_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: bismarck,
            primary: bismarck,
            secondary: laser,
            tertiary: bone),
        //color override
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentNavBarIndex = 0;

  final bottomNavBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
    const BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
  ];

  final _mainMenuItem = <Widget>[
    const HomePage(),
    const MapPage(),
    const PeoplePage()
  ];

  @override
  Widget build(BuildContext context) {
    void _onTapBottomNavBarItem(int index) {
      setState(() {
        _currentNavBarIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavBarItems,
        currentIndex: _currentNavBarIndex,
        onTap: _onTapBottomNavBarItem,
      ),
      body: Center(
        child: _mainMenuItem.elementAt(_currentNavBarIndex),
      ),
    );
  }
}
