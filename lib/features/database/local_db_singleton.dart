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
    _createLifeGoalCategoryRelationship(db);
  }

  _createLifeGoalTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS life_goals(
      firebaseID PRIMARY KEY VARCHAR(20) NOT NULL,
      id AUTOINCREMENT INTEGER,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      isCompleted BOOLEAN NOT NULL,
      dateCreated INT NOT NULL,
      isDeleted BOOLEAN NULL,
      dateDeleted INT NULL,
      location VARCHAR(255) NULL,
      notes TEXT NULL,
      image VARCHAR(255) NULL
    )
    ''');
  }

  _createLifeGoalCategoriesTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS life_goal_categories(
      firebaseID PRIMARY KEY VARCHAR(20) NOT NULL,
      id INTEGER AUTOINCREMENT,
      dateCreated INT NOT NULL,
      label VARCHAR(20) NOT NULL
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
        'dateCreated': DateTime.now().toUtc().millisecondsSinceEpoch
      };
      await db.insert('life_goal_categories', value);
    }
  }

  _createLifeGoalCategoryRelationship(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS life_goal_category_relationship (
      id INTEGER AUTOINCREMENT NOT NULL,
      goal_id VARCHAR(20),
      category_id VARCHAR(20),
      FOREIGN KEY (goal_id) REFERENCES life_goals (firebaseID),
      FOREIGN KEY (category_id) REFERENCES life_goal_categories (firebaseID),
      PRIMARY KEY (goal_id, category_id)
);
  ''');
  }

  _createForSynchTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS for_synch(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      life_goal_id INTEGER, -- Define the column first
      FOREIGN KEY (life_goal_id) REFERENCES life_goals(firebaseID) 
    )
    ''');
  }
}
