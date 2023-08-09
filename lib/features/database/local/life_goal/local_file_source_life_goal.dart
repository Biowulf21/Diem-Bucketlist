import 'dart:async';

import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
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
      lifeGoals = await db.query('life_goals',
          orderBy: 'dateCreated DESC',
          where: 'isDeleted IS NULL OR isDeleted = ?',
          whereArgs: [0]);

      List<LifeGoal> lifeGoalList =
          lifeGoals.map((e) => LifeGoal.fromJson(e)).toList();

      for (var goal in lifeGoalList) {
        List<LifeGoalCategory> lifeGoalCategoryRelationships =
            await LifeGoalCategoryRelationshipDBHelper(instance: db)
                .getCategoriesFromRelationship(goal.firebaseID);

        goal.categories = lifeGoalCategoryRelationships;

        print('lifeGoalCategories: $lifeGoalCategoryRelationships');
      }
      return lifeGoalList;
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
    //TODO: add checks if inseertion of relationships fail and throw error
    // corresponding errors

    int res = await db.insert('life_goals', lifeGoal.toJsonNoCategories());
    return res;
  }

  @override
  Future<int> removeLifeGoal(String id) async {
    Database db = instance;
    return await db
        .delete('life_goals', where: 'firebaseID = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateLifeGoal(LifeGoal lifeGoal) async {
    Database db = instance;
    return await db.update('life_goals', lifeGoal.toJson(),
        where: 'firebaseID = ?', whereArgs: [lifeGoal.firebaseID]);
  }

  @override
  Future<LifeGoal> getLifeGoal(String id) async {
    Database db = instance;
    var lifeGoalFromDB =
        await db.query('life_goals', where: 'firebaseID = ?', whereArgs: [id]);
    LifeGoal lifeGoal = LifeGoal.fromJson(lifeGoalFromDB.first);
    return lifeGoal;
  }
}
