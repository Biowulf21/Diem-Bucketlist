// This will serve as the model for the life items
// Life goals are items that are in the user's bucket list

import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';

class LifeGoal {
  String firebaseID;
  String title;
  String description;
  bool isCompleted;
  bool? isDeleted;
  Timestamp? dateDeleted;
  List<LifeGoalCategory>? categories;
  String? location;
  String? notes;
  String? image;

  LifeGoal(
      {required this.firebaseID,
      required this.title,
      required this.description,
      required this.isCompleted,
      this.isDeleted = false,
      this.id,
      this.dateDeleted,
      this.categories,
      this.location,
      this.notes,
      this.image});

  factory LifeGoal.fromJson(Map<String, dynamic> json) {
    return LifeGoal(
      id: json['id'],
      firebaseID: json['firebaseID'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      isDeleted: json['isDeleted'],
      dateDeleted: json['dateDeleted'],
      categories: json['categories'],
      location: json['location'],
      notes: json['notes'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firebaseID': firebaseID,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'isDeleted': isDeleted,
        'dateDeleted': dateDeleted,
        'categories': categories,
        'location': location,
        'notes': notes,
        'image': image
      };
}
