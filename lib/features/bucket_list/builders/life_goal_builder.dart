import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import '../models/life_goal_category/life_goal_category.dart';

class LifeGoalBuilder {
  String title;
  String id;
  String description;
  bool isCompleted = false;
  bool? isDeleted;
  Timestamp? dateDeleted;
  List<LifeGoalCategory>? categories;
  String? location;
  String? notes;
  String? image;

  LifeGoalBuilder(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted});

  LifeGoalBuilder addCategories(List<LifeGoalCategory> categories) {
    this.categories = categories;
    return this;
  }

  LifeGoalBuilder addLocation(String location) {
    this.location = location;
    return this;
  }

  LifeGoalBuilder addNotes(String notes) {
    this.notes = notes;
    return this;
  }

  LifeGoalBuilder addImage(String image) {
    this.image = image;
    return this;
  }

  LifeGoal build() {
    LifeGoal goal = LifeGoal(
        id: id,
        title: title,
        description: description,
        isCompleted: isCompleted);

    return goal;
  }
}
