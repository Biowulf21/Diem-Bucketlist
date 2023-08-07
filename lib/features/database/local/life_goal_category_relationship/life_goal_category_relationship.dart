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
      LifeGoalCategoryRelationship category) async {
    Database db = instance;

    return db.insert('life_goal_category_relationship', {
      'firebaseID': category.firebaseID,
      'goal_id': category.goalID,
      'category_id': category.categoryID,
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

  Future<List<LifeGoalCategoryRelationship>>
      getLifeGoalCategoryRelationshipsWithLifeGoalID(String id) async {
    Database db = instance;

    const query = '''
          SELECT life_goal_category_relationship.goal_id, life_goal_category_relationship.category_id
          FROM life_goal_category_relationship
          JOIN life_goals lg ON life_goal_category_relationship.goal_id = lg.firebaseID
          WHERE lg.firebaseID = ?;
  ''';

    final List<Map<String, dynamic>> result = await db.rawQuery(query, [id]);
    return result.map((e) => LifeGoalCategoryRelationship.fromJson(e)).toList();
  }

  @override
  Future<int> updateLifeGoalCategoryRelationship(
      LifeGoalCategoryRelationship category) async {
    Database db = instance;

    return await db.update('life_goal_category_relationship', category.toJson(),
        where: 'firebaseID = ?', whereArgs: [category.firebaseID]);
  }
}
