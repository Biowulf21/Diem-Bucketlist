import 'package:diem/features/bucket_list/models/life_goal_category/life_goal_category.dart';
import 'package:diem/features/bucket_list/providers/life_goal_category_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomChip extends ConsumerStatefulWidget {
  CustomChip({super.key, required this.label}) : super();

  final String label;

  @override
  CustomChipState createState() => CustomChipState();
}

class CustomChipState extends ConsumerState<CustomChip> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        if (isSelected) {
          ref.read(selectedCategoryNotifier.notifier).addSelectedCategory(
              LifeGoalCategory(label: widget.label, id: widget.label));
        } else {
          ref
              .read(selectedCategoryNotifier.notifier)
              .removeFromSelectedCategory(
                  LifeGoalCategory(label: widget.label, id: widget.label));
        }
      },
      child: Chip(
        avatar: isSelected
            // ignore: avoid_unnecessary_containers
            ? Container(
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              )
            : null,
        side: isSelected
            ? BorderSide(color: Theme.of(context).colorScheme.primary)
            : const BorderSide(color: Colors.grey),
        labelPadding: const EdgeInsets.all(2.0),
        label: Text(widget.label),
        elevation: 6.0,
        backgroundColor: isSelected == true
            ? Theme.of(context).colorScheme.inversePrimary
            : Theme.of(context).colorScheme.background,
        shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}
