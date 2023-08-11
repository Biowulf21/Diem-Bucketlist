import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class LifeGoalRepository {
  Future<void> addLifeGoal(
      {required String title,
      required String description,
      required List<LifeGoalCategory> selectedCategories,
      required Database db});
  Future<List<LifeGoal>> fetchLifeGoals();
  Future<void> updateLifeGoal(String id, bool isCompleted);
  Future<void> deleteLifeGoal(String id);
}
