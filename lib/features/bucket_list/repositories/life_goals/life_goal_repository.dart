import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';

abstract class LifeGoalRepository {
  Future<void> addLifeItem(LifeItem lifeItem);
  Future<List<LifeItem>> fetchLifeItems();
  Future<void> updateLifeItem(String id, bool isCompleted);
  Future<void> deleteLifeItem(String id);
}
