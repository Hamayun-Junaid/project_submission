import 'package:flutter/material.dart';

class MoodChip extends StatelessWidget {
  final String mood;
  final bool selected;
  final Function(bool) onSelected;

  const MoodChip({
    super.key,
    required this.mood,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(mood),
      selected: selected,
      selectedColor: Colors.teal.shade200,
      onSelected: onSelected,
    );
  }
}
