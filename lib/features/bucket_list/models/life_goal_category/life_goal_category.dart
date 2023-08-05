class LifeGoalCategory {
  String label;
  String firebaseID;
  String? description;

  LifeGoalCategory(
      {required this.label, required this.firebaseID, this.description});

  String get getLabel => label;
  String? get getDescription => description;

  factory LifeGoalCategory.fromJson(Map<String, dynamic> json) =>
      LifeGoalCategory(
        firebaseID: json['firebaseID'],
        label: json['label'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() =>
      {'label': label, 'firebaseID': firebaseID, 'description': description};
}
