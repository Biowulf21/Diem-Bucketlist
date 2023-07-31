import 'dart:async';
import 'dart:io';

import 'package:diem/utils/firebase_doc_id_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDBSingleton {
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

  Future<void> _onCreateDb(Database db, int version) async {
    await _createLifeGoalCategoriesTable(db);
    await _createLifeGoalTable(db);
    await _createForSynchTable(db);
  }

  _createLifeGoalTable(Database db) async {
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

  _createLifeGoalCategoriesTable(Database db) async {
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
        'firebaseID': FirebaseDocIDGenerator.createRandomID(),
        'label': category,
        'dateCreated': DateTime.now().toUtc()
      };
      await db.insert('life_goal_categories', value);
    }
  }

  _createForSynchTable(Database db) async {
    await db.execute('''
    CREATE TABLE for_synch(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      life_goal_id INTEGER, -- Define the column first
      FOREIGN KEY (life_goal_id) REFERENCES life_goals(id) 
    )
    ''');
  }
}
