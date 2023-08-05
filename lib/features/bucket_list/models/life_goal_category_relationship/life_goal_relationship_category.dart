class LifeGoalCategoryRelationship {
  int goalID;
  int categoryID;
  String firebaseID;

  LifeGoalCategoryRelationship({
    required this.firebaseID,
    required this.goalID,
    required this.categoryID,
  });

  factory LifeGoalCategoryRelationship.fromJson(Map<String, dynamic> json) {
    return LifeGoalCategoryRelationship(
        categoryID: json['categoryID'],
        goalID: json['goalID'],
        firebaseID: json['firebaseID']);
  }

  Map<String, dynamic> toJson() {
    return {'goalID': goalID, 'firebaseID': firebaseID};
  }
}
