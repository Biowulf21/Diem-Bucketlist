import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/life_goal_repository_impl.dart';
import 'package:diem/features/database/local/life_goal_category/life_goal_category_local_db_helper.dart';

abstract class RemoteSourceAbstract {
  Future<void> syncToRemote();
  Future<void> syncToLocal();
}

class FirebaseRemoteSource implements RemoteSourceAbstract {
  @override
  Future<void> syncToLocal() {
    // TODO: implement synchToLocal
    throw UnimplementedError();
  }

  @override
  Future<void> syncToRemote() {
    List<LifeGoalCategory> categories = [];
    List<LifeGoal> goals = [];
    List<LifeGoalCategoryRelationship> relationships = [];

    LifeGoalImplRepository goalRepository = LifeGoalImplRepository();
    LifeGoalCat
    try {} catch (e) {}
  }
}
