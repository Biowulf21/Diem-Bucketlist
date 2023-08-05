
class LifeGoalCategory {
  String label;
  String firebaseID;
  String? description;

  LifeGoalCategory(
      {required this.label,
      required this.id,
      required this.firebaseID,
      this.description});

  String get getLabel => label;
  int get getId => id;
  String? get getDescription => description;

  factory LifeGoalCategory.fromJson(Map<String, dynamic> json) =>
      LifeGoalCategory(
        firebaseID: json['firebaseID'],
        label: json['label'],
        id: json['id'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'firebaseID': firebaseID,
        'description': description
      };
}
