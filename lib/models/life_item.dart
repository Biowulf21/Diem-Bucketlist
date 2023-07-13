// This will serve as the model for the life items
// Life items are items that are in the user's bucket list
import 'package:diem/models/life_item_category.dart';

class LifeItem {
  String id;
  String title;
  String description;
  bool isCompleted;
  List<LifeItemCategory>? categories;
  String? location;
  String? image;

  LifeItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted,
      this.categories,
      this.location,
      this.image});
}
