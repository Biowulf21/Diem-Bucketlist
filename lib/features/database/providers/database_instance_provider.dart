import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

final FutureProvider<Database> localLifeGoalCategoryProvider =
    FutureProvider<Database>((ref) async {
  return LocalDBSingleton().database;
});
