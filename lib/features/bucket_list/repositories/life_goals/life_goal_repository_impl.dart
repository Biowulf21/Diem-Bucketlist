import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/life_goal_repository.dart';

class LifeGoalImplRepository implements LifeGoalRepository {
  Future<void> addLifeItem(LifeItem lifeItem) async {
    return Future(() => null);
  }

  Future<List<LifeItem>> fetchLifeItems() {
    return Future(() => [
          LifeItem(
              id: "hehe",
              title: "try lang",
              description: "dse",
              isCompleted: true)
        ]);
  }

  Future<void> updateLifeItem(String id, bool isCompleted) {
    return Future(() => null);
  }

  Future<void> deleteLifeItem(String id) {
    return Future(() => null);
  }
}
