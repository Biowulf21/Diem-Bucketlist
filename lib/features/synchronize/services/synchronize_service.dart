abstract class SynchronizeServiceAbstract{
  Future<void> _syncCategories();
  Future<void> _syncLifeGoals();
  Future<void> _syncLifeGoalCategoryRelationships();
  Future<void> synchronize();

  }

class SynchronizeService implements SynchronizeServiceAbstract{

  }
