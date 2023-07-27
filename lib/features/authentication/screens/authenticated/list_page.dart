import 'package:diem/features/authentication/repositories/auth.dart';
import 'package:diem/features/bucket_list/providers/bucketlist_item_providers.dart';
import 'package:diem/features/bucket_list/repositories/life_goals/widgets/life_goal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends ConsumerState<ListPage> {
  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(lifeGoalListProvider);
    List<LifeGoalWidget> lifeGoals =
        counter.map((goal) => LifeGoalWidget(item: goal)).toList();

    return ListView(
      children: lifeGoals,
    );
  }
}
