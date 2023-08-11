import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/database/local/life_goal/local_file_source_life_goal.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProvider<List<LifeGoal>> lifeGoalListProvider =
    FutureProvider<List<LifeGoal>>((ref) async {
  var db = await LocalDBSingleton().database;
  Future<List<LifeGoal>> localLifeGoals =
      LocalDataSourceLifeGoalImpl(instance: db).getLifeGoals();

  return localLifeGoals;
});
