import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/database/abstract/abstract_data_source.dart';

class FirebaseDataSourceLifeGoal implements AbstractDataSource {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Future<int> addLifeGoal(LifeGoal lifeGoal) {
    // TODO: implement addLifeGoal
    throw UnimplementedError();
  }

  @override
  Future<List<LifeGoal>> getDeletedLifeGoals() {
    // TODO: implement getDeletedLifeGoals
    throw UnimplementedError();
  }

  @override
  Future<LifeGoal> getLifeGoal(String id) {
    // TODO: implement getLifeGoal
    throw UnimplementedError();
  }

  @override
  Future<List<LifeGoal>> getLifeGoals() {
    // TODO: implement getLifeGoals
    throw UnimplementedError();
  }

  @override
  Future<int> removeLifeGoal(String id) {
    // TODO: implement removeLifeGoal
    throw UnimplementedError();
  }

  @override
  Future<int> updateLifeGoal(LifeGoal lifegoal) {
    // TODO: implement updateLifeGoal
    throw UnimplementedError();
  }
}
