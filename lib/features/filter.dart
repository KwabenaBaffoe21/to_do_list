import 'package:flutter/material.dart';

import 'filter_button.dart';

class Filter extends StatelessWidget {
  const Filter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 35,
        ),
        FilterButton(
          label: 'All',
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: FilterButton(
            label: 'Complete',
          ),
        ),
        FilterButton(
          label: 'Uncompleted',
        ),
      ],
    );
  }
}
