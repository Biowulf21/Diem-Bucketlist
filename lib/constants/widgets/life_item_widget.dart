import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:flutter/material.dart';

class LifeItemWidget extends StatelessWidget {
  const LifeItemWidget({super.key, required this.item});
  final LifeItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.description),
      ),
    );
  }
}
