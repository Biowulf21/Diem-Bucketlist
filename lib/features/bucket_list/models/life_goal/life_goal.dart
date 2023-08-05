// This will serve as the model for the life items
// Life goals are items that are in the user's bucket list

import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';

class LifeGoal {
  String firebaseID;
  String title;
  String description;
  bool isCompleted;
  int dateCreated;
  bool? isDeleted;
  DateTime? dateDeleted;
  List<LifeGoalCategory>? categories;
  String? location;
  String? notes;
  String? image;

  LifeGoal(
      {required this.firebaseID,
      required this.title,
      required this.description,
      required this.isCompleted,
      required this.dateCreated,
      this.isDeleted = false,
      this.dateDeleted,
      this.categories,
      this.location,
      this.notes,
      this.image});

  factory LifeGoal.fromJson(Map<String, dynamic> json) {
    return LifeGoal(
        firebaseID: json['firebaseID'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'] == 1 ? true : false,
        isDeleted: json['isDeleted'] == 1 ? true : false,
        dateDeleted: json['dateDeleted'],
        categories: json['categories'],
        location: json['location'],
        notes: json['notes'],
        image: json['image'],
        dateCreated: json['dateCreated']);
  }

  Map<String, dynamic> toJson() => {
        'firebaseID': firebaseID,
        'title': title,
        'description': description,
        'isCompleted': isCompleted == true ? 1 : 0,
        'dateCreated': dateCreated,
        'isDeleted': isDeleted == true ? 1 : 0,
        'dateDeleted': dateDeleted,
        'categories': categories,
        'location': location,
        'notes': notes,
        'image': image
      };

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
