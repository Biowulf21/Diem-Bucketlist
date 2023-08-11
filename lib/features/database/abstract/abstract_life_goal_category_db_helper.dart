import 'dart:async';

import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:sqflite/sqflite.dart';

abstract class AbstractLifeGoalCategoryDBHelper {
  Future<int> createLifeGoalCategory(LifeGoalCategory category);
  Future<List<LifeGoalCategory>> getLifeGoalCategories();
  Future<int> updateLifeGoalCategory(LifeGoalCategory category);
  Future<int> deleteLifeGoalCategory(String id);
}
