import 'package:diem/features/bucket_list/repositories/life_item/life_item_repository.dart';
import 'package:diem/models/life_item.dart';

class LifeItemRepositoryImpl implements LifeItemRepository {
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
