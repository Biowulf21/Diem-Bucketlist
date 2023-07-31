import 'dart:async';
import 'dart:js_interop';

import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';
import 'package:diem/features/database/abstract/abstract_data_source.dart';
import 'package:diem/features/database/local/life_goal_category_relationship/life_goal_category_relationship.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSourceLifeGoalImpl implements AbstractDataSource {
  Database instance;

  LocalDataSourceLifeGoalImpl({required this.instance});

  // CRUD OPERATIONS
  @override
  Future<List<LifeGoal>> getLifeGoals() async {
    Database db = instance;
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
    Database db = instance;
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
    Database db = instance;
    List<LifeGoalCategory>? categories = lifeGoal.categories;
    //TODO: change this signature to List<LifeGoalCategory?> instead. This cannot be null

    if (categories.isNull) throw Exception('Categories cannot be null');

    categories!.forEach((category) {
      LifeGoalCategoryRelationship relationship = LifeGoalCategoryRelationship(
          firebaseID: category.firebaseID,
          goalID: lifeGoal.id,
          categoryID: category.id);
      LifeGoalCategoryRelationshipDBHelper(instance: db)
          .createLifeGoalCategoryRelationship(category);
    });

    return await db.insert('life_goals', lifeGoal.toJson());
  }

  @override
  Future<int> removeLifeGoal(String id) async {
    Database db = instance;
    return await db.delete('life_goals', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateLifeGoal(LifeGoal lifeGoal) async {
    Database db = instance;
    return await db.update('life_goals', lifeGoal.toJson(),
        where: 'id = ?', whereArgs: [lifeGoal.id]);
  }

  @override
  Future<LifeGoal> getLifeGoal(String id) async {
    Database db = instance;
    var lifeGoalFromDB =
        await db.query('life_goal', where: 'id = ?', whereArgs: [id]);
    LifeGoal lifeGoal = LifeGoal.fromJson(lifeGoalFromDB.first);
    return lifeGoal;
  }
}
