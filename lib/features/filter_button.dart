import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.inter(
            color: const Color(0xffffffff),
            fontSize: 12,
            fontWeight: FontWeight.w900),
      ),
      onSelected: (bool isSelected) {
        onSelected();
      },
      selected: isSelected,
      selectedColor: const Color(0xff65558f),
      checkmarkColor: const Color(0xffffffff),
      color: const WidgetStatePropertyAll(
        Color(0xa665558f),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
