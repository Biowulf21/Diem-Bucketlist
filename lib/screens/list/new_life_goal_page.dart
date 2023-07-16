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
    return Center(
      child: Form(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _goalTitleController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(controller: _goalDescriptionController),
            ),
          ],
        ),
      ),
    );
  }
}
