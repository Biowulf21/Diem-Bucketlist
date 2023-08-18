import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';

abstract class LifeGoalCategoryRepositoryAbstract {
  Future<List<LifeGoalCategory>> getCategories();
  Future<void> addCategory({required LifeGoalCategory category});
  Future<void> deleteCategory({required LifeGoalCategory category});
  Future<void> updateCategory({required LifeGoalCategory category});
}
