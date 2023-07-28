import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class AbstractLifeGoalCategoryDBHelper {
  Future<void> createLifeGoalCategoriesTable(Database db);
  Future<void> insertLifeGoalCategories(Database db);
  Future<void> updateLifeGoalCategories(Database db);
  Future<void> deleteLifeGoalCategories(Database db);
}
