import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';

class LifeGoalCategory {
  String label;
  String id;
  String firebaseID;
  String? description;

  LifeGoalCategory(
      {required this.label,
      required this.id,
      required this.firebaseID,
      this.description});

  String get getLabel => label;
  String get getId => id;
  String? get getDescription => description;

  factory LifeGoalCategory.fromJson(Map<String, dynamic> json) =>
      LifeGoalCategory(
        firebaseID: json['firebaseID'],
        label: json['label'],
        id: json['id'].toString(),
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': int.parse(id),
        'label': label,
        'firebaseID': firebaseID,
        'description': description
      };
}
