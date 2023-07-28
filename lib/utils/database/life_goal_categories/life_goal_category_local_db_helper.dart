import 'dart:async';
import 'dart:io';

import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/utils/database/life_goal_categories/abstract_life_goal_category_db_helper.dart';
import 'package:diem/utils/database/life_goals/abstract_data_source.dart';
import 'package:diem/utils/firebase_doc_id_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LifeGoalCategoryDBHelper implements AbstractLifeGoalCategoryDBHelper {
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
    await _createCategoriesTable(db);
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

  @override
  Future<int> deleteLifeGoalCategory(String id) async {
    Database db = await database;
    return await db
        .delete('life_goal_categories', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<LifeGoalCategory>> getLifeGoalCategories() async {
    Database db = await database;
    var isTableEmpty = Sqflite.firstIntValue(
            await db.rawQuery("SELECT COUNT(*) FROM life_goal_categories")) ==
        0;

    var lifeGoals = await db.query('life_goals');

    if (!isTableEmpty) {
      lifeGoals = await db.query('life_goals', orderBy: 'dateCreated');
      List<LifeGoalCategory> lifeGoallist =
          lifeGoals.map((e) => LifeGoalCategory.fromJson(e)).toList();
      return lifeGoallist;
    }
    return [];
  }

  @override
  Future<int> updateLifeGoalCategory(LifeGoalCategory category) async {
    Database db = await database;

    return await db.update('life_goals', category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  @override
  Future<int> createLifeGoalCategory(LifeGoalCategory category) async {
    Database db = await database;
    return await db.insert('life_goal_categories', category.toJson());
  }
}
