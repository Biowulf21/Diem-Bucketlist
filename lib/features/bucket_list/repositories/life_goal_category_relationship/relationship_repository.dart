import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';

abstract class LifeGoalCategoryRelationshipAbstract {
  Future<void> addRelationship(
      {required LifeGoalCategoryRelationship relationship});
  Future<void> deleteRelationship({required String firebaseID});
  Future<List<LifeGoalCategory>> getRelationshipFromGoalID(
      {required String firebaseID});
  Future<List<LifeGoalCategoryRelationship>> getRelationship(
      {required String lifeGoalID, required String categoryID});
}
