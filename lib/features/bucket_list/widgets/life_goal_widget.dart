import 'package:diem/features/bucket_list/models/life_goal/life_goal.dart';
import 'package:diem/features/bucket_list/providers/bucketlist_item_providers.dart';
import 'package:diem/features/database/local/life_goal/local_file_source_life_goal.dart';
import 'package:diem/features/database/local_db_singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

class LifeGoalWidget extends ConsumerWidget {
  const LifeGoalWidget({super.key, required this.item});
  final LifeGoal item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () async {
        Database db = await LocalDBSingleton().database;
        LocalDataSourceLifeGoalImpl(instance: db)
            .removeLifeGoal(item.firebaseID)
            .then((value) {
          ref.invalidate(lifeGoalListProvider);
        });
      },
      child: Card(
        child: ListTile(
            title: Text(item.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.description),
                Text(item.dateCreated.toString())
              ],
            )),
      ),
    );
  }
}
