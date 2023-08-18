import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/database/local/life_goal_category/life_goal_category_local_db_helper.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:sqflite/sqflite.dart';

import 'category_repository.dart';

class LifeGoalCategoryRepositoryImpl
    implements LifeGoalCategoryRepositoryAbstract {
  late Database _instance;

  Future<void> _getDatabaseInstance() async {
    _instance = await LocalDBSingleton().database;
  }

  @override
  Future<String> addCategory({required LifeGoalCategory category}) async {
    int result = await LifeGoalCategoryDBHelper(instance: _instance)
        .createLifeGoalCategory(category);
    return result == 1
        ? "Added category successfully"
        : "Failed to add category";
  }

  @override
  Future<String> deleteCategory({required LifeGoalCategory category}) async {
    int result = await LifeGoalCategoryDBHelper(instance: _instance)
        .createLifeGoalCategory(category);
    return result == 1 ? "Added goal successfully" : "Failed to add goal";
  }

  @override
  Future<List<LifeGoalCategory>> getCategories() async {
    List<LifeGoalCategory> result =
        await LifeGoalCategoryDBHelper(instance: _instance)
            .getLifeGoalCategories();

    return result;
  }

  @override
  Future<String> updateCategory({required LifeGoalCategory category}) async {
    int result = await LifeGoalCategoryDBHelper(instance: _instance)
        .updateLifeGoalCategory(category);

    return result == 1
        ? "Added category successfully"
        : "Failed to add category";
  }
}
