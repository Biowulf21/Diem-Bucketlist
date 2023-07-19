// This will serve as the model for the life items
// Life goals are items that are in the user's bucket list

import 'package:diem/features/bucket_list/models/life_goal/life_goal_category.dart';

class LifeGoal {
  String id;
  String title;
  String description;
  bool isCompleted;
  List<LifeGoalCategory>? categories;
  String? location;
  String? notes;
  String? image;

  LifeGoal(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted,
      this.categories,
      this.location,
      this.notes,
      this.image});
}
