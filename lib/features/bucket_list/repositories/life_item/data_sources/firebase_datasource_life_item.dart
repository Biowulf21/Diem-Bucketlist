import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseDataSourceLifeItemInterface {
  Future<void> fetchLifeItems();
}

class FirebaseDataSourceLifeItem
    implements FirebaseDataSourceLifeItemInterface {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<void> fetchLifeItems() async {}
}
