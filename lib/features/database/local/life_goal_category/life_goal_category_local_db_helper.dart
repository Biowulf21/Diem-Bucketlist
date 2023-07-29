import 'dart:async';

import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/database/abstract/abstract_life_goal_category_db_helper.dart';
import 'package:sqflite/sqflite.dart';

class LifeGoalCategoryDBHelper implements AbstractLifeGoalCategoryDBHelper {
  Database instance;

  LifeGoalCategoryDBHelper({required this.instance});

  @override
  Future<int> deleteLifeGoalCategory(String id) async {
    Database db = instance;
    return await db
        .delete('life_goal_categories', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<LifeGoalCategory>> getLifeGoalCategories() async {
    Database db = instance;
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
    Database db = instance;

    return await db.update('life_goals', category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  @override
  Future<int> createLifeGoalCategory(LifeGoalCategory category) async {
    Database db = instance;
    return await db.insert('life_goal_categories', category.toJson());
  }
}
