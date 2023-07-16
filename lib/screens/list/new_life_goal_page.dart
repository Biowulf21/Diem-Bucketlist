import 'package:flutter/material.dart';

class NewLifeGoalPage extends StatefulWidget {
  const NewLifeGoalPage({super.key});

  @override
  State<NewLifeGoalPage> createState() => _NewLifeGoalPageState();
}

class _NewLifeGoalPageState extends State<NewLifeGoalPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [TextField(), TextField()],
      ),
    );
  }
}
