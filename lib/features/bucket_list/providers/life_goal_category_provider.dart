import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final defaultGoalCategoryProvider = StateProvider<List<String>>((ref) => [
      'family',
      'travel',
      'health',
      'finance',
      'personal',
      'career',
      'education',
      'creative',
      'relationship',
    ]);

final selectedCategoryNotifier =
    StateNotifierProvider<SelectedGoalCategoryNotifier, List<LifeGoalCategory>>(
  (ref) => SelectedGoalCategoryNotifier(),
);

class SelectedGoalCategoryNotifier
    extends StateNotifier<List<LifeGoalCategory>> {
  SelectedGoalCategoryNotifier() : super([]);

  void addSelectedCategory(LifeGoalCategory category) {
    state = [...state, category];
  }

  List<LifeGoalCategory> removeFromSelectedCategory(LifeGoalCategory category) {
    state = state
        .toList()
        .where((element) => category.label != element.label)
        .toList();

    return state;
  }

  List<LifeGoalCategory> getSelectedCategories() {
    return state;
  }
}
