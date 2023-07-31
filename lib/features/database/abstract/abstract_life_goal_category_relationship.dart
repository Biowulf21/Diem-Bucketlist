import 'dart:async';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';

abstract class AbstractLifeGoalCategoryRelationshipoDBHelper {
  Future<int> createLifeGoalCategoryRelationship(
      LifeGoalCategoryRelationship category);

  Future<List<LifeGoalCategoryRelationship>> getLifeGoalCategoryRelationships(
      String lifeGoalID, String categoryID);

  Future<int> updateLifeGoalCategoryRelationship(
      LifeGoalCategoryRelationship category);

  Future<int> deleteLifeGoalCategoryRelationship(int id);
}
