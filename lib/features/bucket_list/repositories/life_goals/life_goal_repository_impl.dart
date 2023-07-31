import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/life_goal_repository.dart';
import 'package:diem/features/database/local/life_goal/local_file_source_life_goal.dart';
import 'package:diem/features/database/remote/firebase_datasource_life_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../providers/life_goal_category_provider.dart';

class LifeGoalImplRepository implements LifeGoalRepository {


  @override
  Future<void> addLifeItem(LifeGoal lifeItem) async {
    return Future(() => null);
  }

  @override
  Future<List<LifeGoal>> fetchLifeGoals() async {
    List<LifeGoal> lifeGoalsFromLocalDataSource =
        await LocalDataSourceLifeGoalImpl(instance: null).getLifeGoals();

    if (lifeGoalsFromLocalDataSource.isEmpty) {
      List<LifeGoal> lifeGoalsFromCloud =
          await FirebaseDataSourceLifeGoal().getLifeGoals();

      return lifeGoalsFromCloud;
    }
    return lifeGoalsFromLocalDataSource;
  }

  @override
  Future<void> updateLifeItem(String id, bool isCompleted) {
    return Future(() => null);
  }

  @override
  Future<void> deleteLifeItem(String id) {
    return Future(() => null);
  }
}
