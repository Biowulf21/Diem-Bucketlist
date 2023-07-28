import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/utils/database/life_goals/local_file_source_life_goal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProvider<List<LifeGoal>> lifeGoalListProvider =
    FutureProvider<List<LifeGoal>>((ref) async {
  Future<List<LifeGoal>> localLifeGoals =
      LocalDataSourceLifeGoalImpl().getLifeGoals();

  return localLifeGoals;
});
