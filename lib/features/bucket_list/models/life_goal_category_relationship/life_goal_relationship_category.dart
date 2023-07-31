class LifeGoalCategoryRelationship {
  int goalID;
  int categoryID;
  int? id;
  String firebaseID;

  LifeGoalCategoryRelationship(
      {required this.firebaseID,
      required this.goalID,
      required this.categoryID,
      this.id});

  factory LifeGoalCategoryRelationship.fromJson(Map<String, dynamic> json) {
    return LifeGoalCategoryRelationship(
        categoryID: json['categoryID'],
        goalID: json['goalID'],
        id: json['id'],
        firebaseID: json['firebaseID']);
  }

  Map<String, dynamic> toJson() {
    return {'goalID': goalID, 'id': id, 'firebaseID': firebaseID};
  }
}
