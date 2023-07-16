import 'package:flutter/material.dart';

class NewLifeGoalPage extends StatefulWidget {
  const NewLifeGoalPage({super.key});

  @override
  State<NewLifeGoalPage> createState() => _NewLifeGoalPageState();
}

class _NewLifeGoalPageState extends State<NewLifeGoalPage> {
  TextEditingController _goalTitleController = TextEditingController();
  TextEditingController _goalDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [TextField(), TextField()],
      ),
    );
  }
}
