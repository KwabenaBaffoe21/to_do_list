import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style:  GoogleFonts.poppins(
            color: const Color(0xffffffff),
            fontSize: 12,
            fontWeight: FontWeight.w900),
      ),
      onSelected: null,
      selectedColor: const Color(0xff65558f),
      color: const WidgetStatePropertyAll(
        Color(0xa665558f),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(99),
        ),
      ),
    );
  }
}