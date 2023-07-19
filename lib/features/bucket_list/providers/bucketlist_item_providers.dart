import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<List<LifeGoal>> lifeGoalListProvider =
    StateProvider<List<LifeGoal>>((ref) => []);
