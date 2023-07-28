import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';

class LifeGoalCategory {
  String label;
  String id;
  String? description;

  LifeGoalCategory({required this.label, required this.id, this.description});

  String get getLabel => label;
  String get getId => id;
  String? get getDescription => description;

  factory LifeGoalCategory.fromJson(Map<String, dynamic> json) =>
      LifeGoalCategory(
        label: json['label'],
        id: json['id'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'label': label, 'description': description};
}
