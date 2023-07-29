import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/database/local/life_goal_category/life_goal_category_local_db_helper.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:diem/utils/widgets/custom_chip.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class LifeGoalCategoriesWidget extends StatefulWidget {
  List<LifeGoalCategory> selectedCategories = [];
  LifeGoalCategoriesWidget({super.key, required this.selectedCategories});

  @override
  State<LifeGoalCategoriesWidget> createState() =>
      _LifeGoalCategoriesWidgetState();
}

class _LifeGoalCategoriesWidgetState extends State<LifeGoalCategoriesWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<LifeGoalCategory>> getChipList() async {
    Database db = await LocalDBSingleton().database;

    List<LifeGoalCategory> categories =
        await LifeGoalCategoryDBHelper(instance: db).getLifeGoalCategories();

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LifeGoalCategory>>(
        future: getChipList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<CustomChip> customChipList = snapshot.data!.map((category) {
              return CustomChip(
                category: category,
                selectedCategories: widget.selectedCategories,
              );
            }).toList();
            return Wrap(
              children: customChipList,
            );
          }
        });
  }
}
