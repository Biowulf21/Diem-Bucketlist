import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/constants/constants.dart';
import 'package:diem/features/authentication/screens/unauthenticated/auth_widget.dart';
import 'package:diem/screens/list_page.dart';
import 'package:diem/screens/map_page.dart';
import 'package:diem/screens/people_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  const bool isUsingEmulators = true;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (isUsingEmulators) {
    connectToEmulators();
  }

  runApp(const MyApp());
}

void connectToEmulators() async {
  final yourLocalIp = Platform.isAndroid ? "127.0.0.1" : "localhost";
  print("connecting to emulators...");

  FirebaseFirestore.instance.useFirestoreEmulator("127.0.0.1", 8080);
  await FirebaseAuth.instance.useAuthEmulator("127.0.0.1", 9099);
  print("done");
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
          seedColor: bandicoot,
        ),
        //color override
        useMaterial3: true,
      ),
      home: const AuthWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
    const ListPage(),
    const MapPage(),
    const PeoplePage()
  ];

  @override
  Widget build(BuildContext context) {
    void onTapBottomNavBarItem(int index) {
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
        onTap: onTapBottomNavBarItem,
      ),
      body: Center(
        child: _mainMenuItem.elementAt(_currentNavBarIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
