// This will serve as the model for the life items
// Life items are items that are in the user's bucket list

class LifeItem {
  String title;
  String description;
  bool isCompleted;
  String? location;
  String? image;

  LifeItem(
      {required this.title,
      required this.description,
      required this.isCompleted,
      this.location,
      this.image});
}
