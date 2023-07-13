import 'package:flutter/material.dart';

class NewLifeItemPage extends StatefulWidget {
  const NewLifeItemPage({super.key});

  @override
  State<NewLifeItemPage> createState() => _NewLifeItemPageState();
}

class _NewLifeItemPageState extends State<NewLifeItemPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [TextField(), TextField()],
      ),
    );
  }
}
