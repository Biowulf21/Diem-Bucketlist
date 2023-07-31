class LifeGoalCategoryRelationship {
  int goalID;
  int categoryID;
  int? id;

  LifeGoalCategoryRelationship(
      {required this.goalID, required this.categoryID, this.id});

  factory LifeGoalCategoryRelationship.fromJson(Map<String, dynamic> json) {
    return LifeGoalCategoryRelationship(
        categoryID: json['categoryID'], goalID: json['goalID'], id: json['id']);
  }

  Map<String, dynamic> toJson(LifeGoalCategoryRelationship relationship) {
    return {
      'goalID': relationship.goalID,
      'categoryID': relationship.goalID,
      'id': relationship.id
    };
  }
}
