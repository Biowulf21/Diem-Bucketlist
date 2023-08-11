import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget({super.key, required this.categories});

  List<LifeGoalCategory> categories;

  List<Widget> createCategoryChips(List<LifeGoalCategory> cat) {
    List<Widget> chips = [];
    for (var element in cat) {
      chips.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          child: Chip(
            label: Text(element.label),
          ),
        ),
      );
    }

    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: createCategoryChips(categories),
    );
  }
}
