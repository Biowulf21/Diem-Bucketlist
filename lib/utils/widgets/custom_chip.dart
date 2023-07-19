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
            : const BorderSide(),
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
