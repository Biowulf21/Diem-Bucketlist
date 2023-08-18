abstract class SynchronizeServiceAbstract {
  Future<void> _syncCategories();
  Future<void> _syncLifeGoals();
  Future<void> _syncLifeGoalCategoryRelationships();
  Future<void> synchronize();
}

class SynchronizeService implements SynchronizeServiceAbstract {
  @override
  Future<void> _syncCategories() {
    // TODO: implement _syncCategories
    throw UnimplementedError();
  }

  @override
  Future<void> _syncLifeGoalCategoryRelationships() {
    // TODO: implement _syncLifeGoalCategoryRelationships
    throw UnimplementedError();
  }

  @override
  Future<void> _syncLifeGoals() {
    // TODO: implement _syncLifeGoals
    throw UnimplementedError();
  }

  @override
  Future<void> synchronize() {
    // TODO: implement synchronize
    throw UnimplementedError();
  }
}
