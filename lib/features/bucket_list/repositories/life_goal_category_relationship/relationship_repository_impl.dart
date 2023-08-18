import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';
import 'package:diem/features/bucket_list/repositories/life_goal_category_relationship/relationship_repository.dart';
import 'package:diem/features/database/local/life_goal_category_relationship/life_goal_category_relationship.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:sqflite/sqflite.dart';

class LifeGoalCategoryRelationshipImpl
    implements LifeGoalCategoryRelationshipAbstract {
  late Database _instance;

  LifeGoalCategoryRelationshipImpl() {
    _getDatabase();
  }

  void _getDatabase() async {
    _instance = await LocalDBSingleton().database;
  }

  @override
  Future<String> addRelationship(
      {required LifeGoalCategoryRelationship relationship}) async {
    int result = await LifeGoalCategoryRelationshipDBHelper(instance: _instance)
        .createLifeGoalCategoryRelationship(relationship);
    return result == 1
        ? 'Successfully added relationship'
        : 'Failed to add relationship';
  }

  @override
  Future<String> deleteRelationship({required String firebaseID}) async {
    int result = await LifeGoalCategoryRelationshipDBHelper(instance: _instance)
        .deleteLifeGoalCategoryRelationship(firebaseID);
    return result == 1
        ? 'Successfully added relationship'
        : 'Failed to add relationship';
  }

  @override
  Future<List<LifeGoalCategory>> getRelationshipFromGoalID(
      {required String firebaseID}) async {
    List<LifeGoalCategory> categories =
        await LifeGoalCategoryRelationshipDBHelper(instance: _instance)
            .getCategoriesFromRelationship(firebaseID);

    return categories;
  }

  @override
  Future<List<LifeGoalCategoryRelationship>> getRelationship(
      {required String lifeGoalID, required String categoryID}) async {
    List<LifeGoalCategoryRelationship> relationship =
        await LifeGoalCategoryRelationshipDBHelper(instance: _instance)
            .getLifeGoalCategoryRelationships(lifeGoalID, categoryID);

    return relationship;
  }

  @override
  Future<List<LifeGoalCategoryRelationship>> getAllRelationships()async{

    List<LifeGoalCategoryRelationship> relationship =
        await LifeGoalCategoryRelationshipDBHelper(instance: _instance)
            .getAllRelationships();

    return relationship;
    }




}
