import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/data_sources/local_file_source_life_goal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProvider<List<LifeGoal>> lifeGoalListProvider =
    FutureProvider<List<LifeGoal>>((ref) async {
  Future<List<LifeGoal>> localLifeGoals =
      LocalDataSourceLifeGoalImpl().getLifeGoals();

  return localLifeGoals;
});
