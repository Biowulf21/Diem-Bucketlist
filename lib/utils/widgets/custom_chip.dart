import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  CustomChip({super.key, required this.label});

  String label;

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Chip(
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
