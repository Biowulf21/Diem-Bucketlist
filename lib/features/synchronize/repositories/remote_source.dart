import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/models/life_goal_category_relationship/life_goal_relationship_category.dart';
import 'package:diem/features/bucket_list/repositories/life_goal_category/category_repository_impl.dart';
import 'package:diem/features/bucket_list/repositories/life_goal_category_relationship/relationship_repository_impl.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/life_goal_repository_impl.dart';

abstract class RemoteSourceAbstract {
  Future<void> syncToRemote();
  Future<void> syncToLocal();
}

class FirebaseRemoteSource implements RemoteSourceAbstract {
  // Firebase variables
  String USER_ID;
  FirebaseFirestore _FIRESTORE = FirebaseFirestore.instance;

  FirebaseRemoteSource({required this.USER_ID});

  //PATHS
  final String _ROOT_PATH = 'users';
  String get _USER_PATH => '$_ROOT_PATH/$USER_ID';
  String get _GOAL_PATH => '$_USER_PATH/goals';
  String get _CATEGORIES_PATH => '$_USER_PATH/categories';
  String get _RELATIONSHIPS_PATH => '$_USER_PATH/relationships';
  String get _SETTINGS_PATH => '$_USER_PATH/settings';

  @override
  Future<void> syncToLocal() {
    // TODO: implement synchToLocal
    throw UnimplementedError();
  }

  @override
  Future<void> syncToRemote() async {
    LifeGoalImplRepository goalRepository = LifeGoalImplRepository();
    LifeGoalCategoryRepositoryImpl categoryRepository =
        LifeGoalCategoryRepositoryImpl();
    LifeGoalCategoryRelationshipImpl relationshipRepository =
        LifeGoalCategoryRelationshipImpl();

    List<LifeGoalCategory> categories =
        await categoryRepository.getCategories();
    List<LifeGoal> goals = await goalRepository.fetchLifeGoals();
    List<LifeGoalCategoryRelationship> relationships =
        await relationshipRepository.getAllRelationships();

    final bool isFirstTime = await _checkIfFirstTimeSynch();

    if (isFirstTime) {
      await _createUserCollectionsOnFirstTry();
    }

    try {
      _syncCategories(categories);
      _syncGoals(goals);
      _syncRelationships(relationships);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _syncGoals(List<LifeGoal> goals) async {
    goals.forEach((goal) async {
      await _FIRESTORE
          .collection(_GOAL_PATH)
          .doc(goal.firebaseID)
          .set(goal.toJson());
    });
  }

  Future<void> _syncCategories(List<LifeGoalCategory> categories) async {
    categories.forEach((category) async {
      await _FIRESTORE
          .collection(_CATEGORIES_PATH)
          .doc(category.firebaseID)
          .set(category.toJson());
    });
  }

  Future<void> _syncRelationships(
      List<LifeGoalCategoryRelationship> relationships) async {
    relationships.forEach((relationship) async {
      await _FIRESTORE
          .collection(_RELATIONSHIPS_PATH)
          .doc(relationship.firebaseID)
          .set(relationship.toJson());
    });
  }

  Future<bool> _checkIfFirstTimeSynch() async {
    QuerySnapshot result = await _FIRESTORE.collection(_USER_PATH).get();
    return result.docs.length > 0 ? true : false;
  }

  // creates all user collections if this is the first time synchronizing
  Future<void> _createUserCollectionsOnFirstTry() async {
    await _FIRESTORE.collection(_USER_PATH).add({'collection_exists': true});

    await _FIRESTORE
        .collection(_CATEGORIES_PATH)
        .add({'collection_exists': true});

    await _FIRESTORE
        .collection(_RELATIONSHIPS_PATH)
        .add({'collection_exists': true});

    await _FIRESTORE
        .collection(_SETTINGS_PATH)
        .add({'collection_exists': true});
  }
}
