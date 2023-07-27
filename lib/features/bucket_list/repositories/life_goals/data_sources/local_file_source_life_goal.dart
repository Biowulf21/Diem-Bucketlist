import 'dart:async';
import 'dart:io';

import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDataSourceLifeGoalInterface {}

class LocalDataSourceLifeGoalImpl implements LocalDataSourceLifeGoalInterface {
  Database? _instance;
  Future<Database> get database async {
    if (_instance != null) return _instance!;

    _instance = await _initDB('main.db');
    return _instance!;
  }


  Future<Database> _initDB(String filePath) async {
    Directory dbDirectory = await getApplicationSupportDirectory();
    String path = join(dbDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreateDb);
  }

  FutureOr<void> _onCreateDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE life_goals()
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT,
      isCompleted INTEGER
    )
    ''');
  }

// CRUD OPERATIONS
  Future<List<LifeGoal>> getLifeGoals() async {
    Database db = await database;
    var life_goals = await db.query('life_goals', orderBy: 'date_created');
  }
}
