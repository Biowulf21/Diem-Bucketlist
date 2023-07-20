import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';

class LifeGoalCategory {
  final String label;
  final String id;
  final String? description;

  LifeGoalCategory({required this.label, required this.id, this.description});

  String get getLabel => label;
  String get getId => id;
  String? get getDescription => description;
}
