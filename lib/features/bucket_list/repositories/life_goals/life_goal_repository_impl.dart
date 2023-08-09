import 'package:diem/features/bucket_list/builders/life_goal_builder.dart';
import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/life_goal_repository.dart';
import 'package:diem/features/database/local/life_goal/local_file_source_life_goal.dart';
import 'package:diem/features/database/local/life_goal_category_relationship/life_goal_category_relationship.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:diem/features/database/remote/firebase_datasource_life_item.dart';
import 'package:diem/utils/firebase_doc_id_generator.dart';
import 'package:sqflite/sqlite_api.dart';

class LifeGoalImplRepository implements LifeGoalRepository {
  @override
  Future<void> addLifeGoal(
      {required String title,
      required String description,
      required List<LifeGoalCategory> selectedCategories,
      required Database db}) async {
    final String firebaseID = FirebaseDocIDGenerator.createRandomID();

    LifeGoal goal = LifeGoalBuilder(
            firebaseID: firebaseID,
            title: title,
            description: description,
            isCompleted: false)
        .addCategories(selectedCategories)
        .build();

    var res = await LocalDataSourceLifeGoalImpl(instance: db).addLifeGoal(goal);

    if (goal.categories!.isNotEmpty) {
      var counter = 0;
      List<LifeGoalCategoryRelationship> relationshipList = [];
      for (var category in goal.categories!) {
        LifeGoalCategoryRelationship relationship =
            LifeGoalCategoryRelationship(
          goalID: goal.firebaseID,
          categoryID: category.firebaseID,
          firebaseID: FirebaseDocIDGenerator.createRandomID(),
        );

        relationshipList.add(relationship);
        counter++;
      }

      relationshipList.forEach((element) async {
        var relationshipResult =
            await LifeGoalCategoryRelationshipDBHelper(instance: db)
                .createLifeGoalCategoryRelationship(element);
      });
    }

    // if (goal.categories!.isNotEmpty) {
    //   for (var category in goal.categories!) {
    //
    //     for (var relationship in relationships) {
    //       // TODO: check if insertions of relationships fail
    //       // and throw appropriate errors
    //
    //       var relationshipResult =
    //           await LifeGoalCategoryRelationshipDBHelper(instance: db)
    //               .createLifeGoalCategoryRelationship(relationship);
    //     }
    //   }
    // }
  }

  @override
  Future<List<LifeGoal>> fetchLifeGoals() async {
    Database instance = await LocalDBSingleton().database;
    List<LifeGoal> lifeGoalsFromLocalDataSource =
        await LocalDataSourceLifeGoalImpl(instance: instance).getLifeGoals();

    if (lifeGoalsFromLocalDataSource.isEmpty) {
      List<LifeGoal> lifeGoalsFromCloud =
          await FirebaseDataSourceLifeGoal().getLifeGoals();

      return lifeGoalsFromCloud;
    }
    return lifeGoalsFromLocalDataSource;
  }

  @override
  Future<void> updateLifeGoal(String id, bool isCompleted) {
    return Future(() => null);
  }

  @override
  Future<void> deleteLifeGoal(String id) {
    return Future(() => null);
  }
}
