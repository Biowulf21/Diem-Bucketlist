// ignore: unused_import
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';
import 'package:diem/features/database/abstract/abstract_life_goal_category_relationship.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';

class LifeGoalCategoryRelationshipDBHelper
    implements AbstractLifeGoalCategoryRelationshipoDBHelper {
  Database instance;

  LifeGoalCategoryRelationshipDBHelper({required this.instance});

  @override
  Future<int> createLifeGoalCategoryRelationship(
      LifeGoalCategoryRelationship relationship) async {
    Database db = instance;

    return db.insert('life_goal_category_relationship', {
      'goal_id': relationship.goalID,
      'category_id': relationship.categoryID,
    });
  }

  @override
  Future<int> deleteLifeGoalCategoryRelationship(String id) {
    Database db = instance;
    return db.delete('life_goal_category_relationship',
        where: 'firebaseID = ?', whereArgs: [id]);
  }

  @override
  Future<List<LifeGoalCategoryRelationship>> getLifeGoalCategoryRelationships(
      String lifeGoalID, String? categoryID) async {
    Database db = instance;

    var isTableEmpty = firstIntValue(await db.rawQuery(
            "SELECT COUNT(*) FROM life_goal_category_relationship")) ==
        0;

    var lifeGoals = await db.query(
      'life_goal_category_relationship',
    );

    if (!isTableEmpty) {
      lifeGoals = await db.query('life_goal_category_relationship',
          orderBy: 'dateCreated');
      List<LifeGoalCategoryRelationship> lifeGoalRelationships = lifeGoals
          .map((e) => LifeGoalCategoryRelationship.fromJson(e))
          .toList();
      return lifeGoalRelationships;
    }
    return [];
  }

  Future<List<LifeGoalCategory>> getCategoriesFromRelationship(
      String id) async {
    Database db = instance;

    //TODO: correct this query: so far it says that firebaseID is not found
    // categories table
    const query = '''
      SELECT lgr.goal_id,
            lg.title AS goal_title,
            lgc.firebaseID AS category_id,
            lgc.label AS category_label
      FROM life_goal_category_relationship AS lgr
      INNER JOIN life_goals AS lg ON lgr.goal_id = lg.firebaseID
      INNER JOIN life_goal_categories AS lgc ON lgr.category_id = lgc.firebaseID
      WHERE lg.firebaseID = ?;
  ''';

    final List<Map<String, dynamic>> result = await db.rawQuery(query, [id]);
    return result
        .map((e) => LifeGoalCategory(
            label: e['category_label'], firebaseID: e['category_id']))
        .toList();
  }

  @override
  Future<int> updateLifeGoalCategoryRelationship(
      LifeGoalCategoryRelationship category) async {
    Database db = instance;

    return await db.update('life_goal_category_relationship', category.toJson(),
        where: 'firebaseID = ?', whereArgs: [category.firebaseID]);
  }
}
