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
    CREATE TABLE life_goals(
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      isCompleted BOOLEAN NOT NULL,
      isDeleted BOOLEAN NULL,
      dateDeleted TIMESTAMP NULL,
      location VARCHAR(255) NULL,
      notes TEXT NULL,
      image VARCHAR(255) NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE for_synch(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      life_goal_id FOREIGN KEY (life_goal_id) REFERENCES life_goals(id),
    )
    ''');
  }

// CRUD OPERATIONS
  // CRUD OPERATIONS
  Future<List<LifeGoal>> getLifeGoals() async {
    Database db = await database;
    var lifeGoals = await db.query('life_goals', orderBy: 'date_created');
    List<LifeGoal> lifeGoalList = lifeGoals.isNotEmpty
        ? lifeGoals.map((e) => LifeGoal.fromJson(e)).toList()
        : [];
    return lifeGoalList;
  }

  Future<List<LifeGoal>> getDeletedLifeGoals() async {
    Database db = await database;
    var getDeletedLifeGoals = await db.rawQuery('''
      SELECT * FROM life_goals WHERE isDeleted = 1 ORDER BY date_created
      ''');
    List<LifeGoal> deletedLifeGoals = getDeletedLifeGoals.isNotEmpty
        ? getDeletedLifeGoals.map((e) => LifeGoal.fromJson(e)).toList()
        : [];

    return deletedLifeGoals;
  }

  Future<int> addLifeGoal(LifeGoal lifeGoal) async {
    Database db = await database;
    return await db.insert('life_goals', lifeGoal.toJson());
  }

  Future<int> removeLifeGoal(String id) async {
    Database db = await database;
    return await db.delete('life_goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateLifeGoal(LifeGoal lifeGoal) async {
    Database db = await database;
    return await db.update('life_goals', lifeGoal.toJson(),
        where: 'id = ?', whereArgs: [lifeGoal.id]);
  }
}
