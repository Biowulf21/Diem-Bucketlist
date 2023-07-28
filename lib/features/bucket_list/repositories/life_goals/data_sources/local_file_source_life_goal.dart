import 'dart:async';
import 'dart:io';

import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/data_sources/abstract_data_source.dart';
import 'package:diem/utils/firebase_doc_id_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceLifeGoalImpl implements AbstractDataSource {
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
    await _createLifeGoalTable(db);
    await _createForSynchTable(db);
    await _createCategoriesTable(db);
  }

  Future<void> _createLifeGoalTable(Database db) async {
    await db.execute('''
    CREATE TABLE life_goals(
      id INTEGER PRIMARY KEY,
      firebaseID VARCHAR(20) NOT NULL,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      isCompleted BOOLEAN NOT NULL,
      dateCreated TIMESTAMP NOT NULL,
      isDeleted BOOLEAN NULL,
      dateDeleted TIMESTAMP NULL,
      location VARCHAR(255) NULL,
      notes TEXT NULL,
      image VARCHAR(255) NULL
    )
    ''');
  }

  Future<void> _createForSynchTable(Database db) async {
    await db.execute('''
    CREATE TABLE for_synch(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      life_goal_id INTEGER, -- Define the column first
      FOREIGN KEY (life_goal_id) REFERENCES life_goals(id) 
    )
    ''');
  }

  Future<void> _createCategoriesTable(Database db) async {
    await db.execute('''
    CREATE TABLE life_goal_categories(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firebaseID VARCHAR(20) NOT NULL,
      label VARCHAR(20) NOT NULL,
    )
    ''');

    List<String> defaultCategories = [
      'family',
      'travel',
      'health',
      'finance',
      'personal',
      'career',
      'education',
      'creative',
      'relationship',
    ];

    for (final category in defaultCategories) {
      var value = {
        'firebaseID': FirebaseDocIDGenerator.generateRandomString(),
        'label': category
      };

      await db.insert('life_goal_categories', value);
    }
  }

  // CRUD OPERATIONS
  @override
  Future<List<LifeGoal>> getLifeGoals() async {
    Database db = await database;
    var isTableEmpty = Sqflite.firstIntValue(
            await db.rawQuery("SELECT COUNT(*) FROM life_goals")) ==
        0;

    var lifeGoals = await db.query('life_goals');

    if (!isTableEmpty) {
      lifeGoals = await db.query('life_goals', orderBy: 'dateCreated');
      List<LifeGoal> lifeGoallist =
          lifeGoals.map((e) => LifeGoal.fromJson(e)).toList();
      return lifeGoallist;
    }
    return [];
  }

  @override
  Future<List<LifeGoal>> getDeletedLifeGoals() async {
    Database db = await database;
    var getDeletedLifeGoals = await db.rawQuery('''
      SELECT * FROM life_goals WHERE isDeleted = 1 ORDER BY dateCreated
      ''');
    List<LifeGoal> deletedLifeGoals = getDeletedLifeGoals.isNotEmpty
        ? getDeletedLifeGoals.map((e) => LifeGoal.fromJson(e)).toList()
        : [];

    return deletedLifeGoals;
  }

  @override
  Future<int> addLifeGoal(LifeGoal lifeGoal) async {
    Database db = await database;
    return await db.insert('life_goals', lifeGoal.toJson());
  }

  @override
  Future<int> removeLifeGoal(String id) async {
    Database db = await database;
    return await db.delete('life_goals', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateLifeGoal(LifeGoal lifeGoal) async {
    Database db = await database;
    return await db.update('life_goals', lifeGoal.toJson(),
        where: 'id = ?', whereArgs: [lifeGoal.id]);
  }

  @override
  Future<LifeGoal> getLifeGoal(String id) async {
    Database db = await database;
    var lifeGoalFromDB =
        await db.query('life_goal', where: 'id = ?', whereArgs: [id]);
    LifeGoal lifeGoal = LifeGoal.fromJson(lifeGoalFromDB.first);
    return lifeGoal;
  }
}
