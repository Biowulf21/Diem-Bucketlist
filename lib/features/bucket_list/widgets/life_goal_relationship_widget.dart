import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key, required this.categories});

  List<LifeGoalCategory> categories;

  List<Widget> createTextFields(List<LifeGoalCategory> cat) {
    List<Widget> textFields = [];
    cat.forEach((element) {
      textFields.add(Text('${element.label}: ${element.firebaseID}'));
    });

    return textFields;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: createTextFields(categories),
    );
  }
}
