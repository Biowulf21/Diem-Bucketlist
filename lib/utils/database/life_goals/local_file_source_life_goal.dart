import 'dart:async';
import 'dart:io';

import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/utils/database/life_goals/abstract_data_source.dart';
import 'package:diem/utils/firebase_doc_id_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceLifeGoalImpl implements AbstractDataSource {
  Database instance;

  LocalDataSourceLifeGoalImpl({required this.instance});

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
