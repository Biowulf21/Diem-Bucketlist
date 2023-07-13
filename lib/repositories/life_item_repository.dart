import 'package:diem/models/life_item.dart';

abstract class LifeItemRepository {
  Future<void> addLifeItem(LifeItem lifeItem);
  Future<List<LifeItem>> fetchLifeItems();
  Future<void> updateLifeItem(String id, bool isCompleted);
  Future<void> deleteLifeItem(String id);
}
