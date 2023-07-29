import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';

abstract class AbstractDataSource {
  Future<List<LifeGoal>> getLifeGoals();
  Future<List<LifeGoal>> getDeletedLifeGoals();
  Future<LifeGoal> getLifeGoal(String id);
  Future<int> addLifeGoal(LifeGoal lifeGoal);
  Future<int> removeLifeGoal(String id);
  Future<int> updateLifeGoal(LifeGoal lifegoal);
}
