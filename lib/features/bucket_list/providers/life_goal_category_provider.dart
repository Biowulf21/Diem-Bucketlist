import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/database/local/life_goal_category/life_goal_category_local_db_helper.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

// final defaultGoalCategoryProvider = StateProvider<List<String>>((ref) => [
//       'family',
//       'travel',
//       'health',
//       'finance',
//       'personal',
//       'career',
//       'education',
//       'creative',
//       'relationship',
//     ]);
//
// final selectedCategoryNotifier = StateNotifierProvider.autoDispose<
//     SelectedGoalCategoryNotifier, List<LifeGoalCategory>>(
//   (ref) => SelectedGoalCategoryNotifier(),
// );
//
// class SelectedGoalCategoryNotifier
//     extends StateNotifier<List<LifeGoalCategory>> {
//   SelectedGoalCategoryNotifier() : super([]);
//
//   void addSelectedCategory(LifeGoalCategory category) {
//     state = [...state, category];
//   }
//
//   List<LifeGoalCategory> removeFromSelectedCategory(
//       LifeGoalCategory removeCategory) {
//     state = [
//       for (final category in state)
//         if (category.label != removeCategory.label) category,
//     ];
//     return state;
//   }
//
//   void clearSelectedCategories() {
//     state = [];
//   }
//
//   List<LifeGoalCategory> getSelectedCategories() {
//     return state;
//   }
// }

final FutureProvider<List<LifeGoalCategory>> localLifeGoalCategoryProvider =
    FutureProvider<List<LifeGoalCategory>>((ref) async {
  Database db = await LocalDBSingleton().database;
  return await LifeGoalCategoryDBHelper(instance: db).getLifeGoalCategories();
});
