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
    List<Widget> lifeGoals = counter.when(loading: () {
      return [const Text("Loading")];
    }, error: (err, stack) {
      return [Text("An error has occured: $err")];
    }, data: (data) {
      var lifeGoalWidgetList =
          data.map((e) => LifeGoalWidget(item: e)).toList();
      return lifeGoalWidgetList;
    });

    return ListView(
      children: lifeGoals.isNotEmpty
          ? lifeGoals
          : [
              const Center(
                child: Text("No Life Goals Yet"),
              ),
            ],
    );
  }
}
