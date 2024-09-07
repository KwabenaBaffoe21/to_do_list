import 'package:flutter/material.dart';

import 'filter_button.dart';

class TaskFilter extends StatefulWidget {
  final Function(String) onFilterChanged;

  const TaskFilter({super.key, required this.onFilterChanged});

  @override
  State<TaskFilter> createState() => _TaskFilterState();
}

class _TaskFilterState extends State<TaskFilter> {
  String selectedFilter = 'All';

  void onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    widget.onFilterChanged(filter); // Notify parent about the filter change
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 35),
        FilterButton(
          label: 'All',
          isSelected: selectedFilter == 'All',
          onSelected: () => onFilterSelected('All'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FilterButton(
            label: 'Completed',
            isSelected: selectedFilter == 'Completed',
            onSelected: () => onFilterSelected('Completed'),
          ),
        ),
        FilterButton(
          label: 'Incomplete',
          isSelected: selectedFilter == 'Incomplete',
          onSelected: () => onFilterSelected('Incomplete'),
        ),
      ],
    );
  }
}
