import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/constants/constants.dart';
import 'package:diem/features/authentication/screens/unauthenticated/auth_widget.dart';
import 'package:diem/features/bucket_list/models/life_goal/life_goal_category.dart';
import 'package:diem/screens/list_page.dart';
import 'package:diem/screens/map_page.dart';
import 'package:diem/screens/people_page.dart';
import 'package:diem/utils/input_validator.dart';
import 'package:diem/utils/widgets/custom_chip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  runApp(const ProviderScope(child: MyApp()));
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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  // State<MyHomePage> createState() => _MyHomePageState();
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
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

    List<LifeGoalCategory> lifeGoalCategories = [];

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
        onPressed: () => _newLifeGoalModal(context, lifeGoalCategories),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _newLifeGoalModal(
      BuildContext context, List<LifeGoalCategory> lifeGoalCategories) {
    TextEditingController titleController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: ListView(children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                    validator: (value) {
                      String? validationResult = InputValidator(input: value)
                          .isRequired()
                          .maxLength(maxLength: 20)
                          .validate();

                      return validationResult;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Description"), hintMaxLines: 4),
                    validator: (value) {
                      String? result = InputValidator(input: value)
                          .isRequired()
                          .maxLength(maxLength: 250)
                          .validate();

                      return result;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text("Categories"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: _chipList(),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Location"), hintMaxLines: 4),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Notes"), hintMaxLines: 4),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Image"), hintMaxLines: 4),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                        },
                        child: const Text("CREATE NEW LIFE GOAL")),
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  _chipList() {
    List<String> lifeGoalCategories =
        LifeGoalCategory.values.map((category) => category.name).toList();

    List<Widget> categoriesToChips = lifeGoalCategories
        .map(
          (e) => CustomChip(label: e),
        )
        .toList();

    ElevatedButton addCategory = ElevatedButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );

    return Container(
      child: Wrap(
        children: [...categoriesToChips, addCategory],
        spacing: 6.0,
        runSpacing: 6.0,
      ),
    );
  }
}
