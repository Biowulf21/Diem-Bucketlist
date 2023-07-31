import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import '../models/life_goal_category/life_goal_category.dart';

class LifeGoalBuilder {
  String title;
  String firebaseID;
  String? id;
  String description;
  bool isCompleted = false;
  bool? _isDeleted;
  Timestamp? _dateDeleted;
  List<LifeGoalCategory>? _categories;
  String? _location;
  String? _notes;
  String? _image;

  LifeGoalBuilder(
      {required this.firebaseID,
      required this.title,
      required this.description,
      required this.isCompleted});

  LifeGoalBuilder addCategories(List<LifeGoalCategory> categories) {
    _categories = categories;
    return this;
  }

  LifeGoalBuilder addLocation(String location) {
    _location = location;
    return this;
  }

  LifeGoalBuilder addNotes(String notes) {
    _notes = notes;
    return this;
  }

  LifeGoalBuilder addImage(String image) {
    _image = image;
    return this;
  }

  LifeGoal build() {
    LifeGoal goal = LifeGoal(
        firebaseID: firebaseID,
        title: title,
        categories: _categories,
        description: description,
        isCompleted: isCompleted);

    return goal;
  }
}
