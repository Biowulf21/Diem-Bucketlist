import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:flutter/material.dart';

abstract class LifeGoalRepository {
  Future<void> addLifeItem(LifeGoal lifeItem);
  Future<List<LifeGoal>> fetchLifeGoals();
  Future<void> updateLifeItem(String id, bool isCompleted);
  Future<void> deleteLifeItem(String id);
}
