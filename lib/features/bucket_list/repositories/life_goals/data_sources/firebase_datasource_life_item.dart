import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDataSourceLifeGoalInterface {
  Future<void> fetchLifeItems();
}

class FirebaseDataSourceLifeGoal
    implements FirebaseDataSourceLifeGoalInterface {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<void> fetchLifeItems() async {}
}
