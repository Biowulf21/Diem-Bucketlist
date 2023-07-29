import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/constants/constants.dart';
import 'package:diem/features/authentication/screens/authenticated/list_page.dart';
import 'package:diem/features/authentication/screens/authenticated/map_page.dart';
import 'package:diem/features/authentication/screens/authenticated/people_page.dart';
import 'package:diem/features/authentication/screens/unauthenticated/auth_widget.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/providers/life_goal_category_provider.dart';
import 'package:diem/features/bucket_list/widgets/life_goal_categories_widget.dart';
import 'package:diem/features/database/local/life_goal_category/life_goal_category_local_db_helper.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:diem/utils/input_validator.dart';
import 'package:diem/utils/widgets/custom_chip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';
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

  FirebaseFirestore.instance.useFirestoreEmulator(yourLocalIp, 8080);
  await FirebaseAuth.instance.useAuthEmulator(yourLocalIp, 9099);
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
  const MyHomePage({super.key}) : super();

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    // TODO: create tables for life_goals, life_goal_category, and sync_queue
    // TODO rename for_synch to sync_queue
    super.initState();
    getDatabaseInstance();
  }

  void getDatabaseInstance() async {
    var database = await LocalDBSingleton().database;
    var tableNames = (await database
            .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);

    print(tableNames);
  }

  String update = 'Oya Update Jhoor';
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

  List<LifeGoalCategory> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    void onTapBottomNavBarItem(int index) {
      setState(() {
        _currentNavBarIndex = index;
      });
    }

    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
          onPressed: () => _showBottomSheet(),
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  void _showBottomSheet() {
    TextEditingController titleController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
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
                      // Text(selectedCategories
                      //     .map((element) => element.getLabel.toString())
                      //     .join(", ")),
                      //
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          label: Text("Title"),
                        ),
                        validator: (value) {
                          String? validationResult =
                              InputValidator(input: value)
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
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                            ),
                            child: LifeGoalCategoriesWidget(
                                selectedCategories: selectedCategories),
                          )),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                      //   child: Container(
                      //     padding: const EdgeInsets.all(15),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Colors.red,
                      //         width: 2,
                      //       ),
                      //     ),
                      //     child: _chipList(),
                      //   ),

                      TextFormField(
                        decoration: const InputDecoration(
                            label: Text("Location"), hintMaxLines: 4),
                      ),
                      TextFormField(
                        maxLength: 300,
                        maxLines: 6,
                        minLines: 1,
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
                      ),
                    ]),
                  ),
                ),
              ),
            );
          });
        });
  }

  _chipList() async {
    Database db = await LocalDBSingleton().database;

    List<LifeGoalCategory> categories =
        await LifeGoalCategoryDBHelper(instance: db).getLifeGoalCategories();

    List<CustomChip> customChipList = categories
        .map((e) => CustomChip(
              category: e,
              selectedCategories: selectedCategories,
            ))
        .toList();

    return Wrap(
      children: customChipList,
    );
  }
}
