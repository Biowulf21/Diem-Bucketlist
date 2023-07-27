// This will serve as the model for the life items
// Life goals are items that are in the user's bucket list

import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';

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

  factory LifeGoal.fromJson(Map<String, dynamic> json) {
    return LifeGoal(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        categories: json['categories'],
        location: json['location'],
        notes: json['notes'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'categories': categories,
        'location': location,
        'notes': notes,
        'image': image
      };
}
