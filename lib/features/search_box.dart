import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.onSearchChanged,
  });

  final Function(String) onSearchChanged;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 25,
      onChanged: widget.onSearchChanged,
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: GoogleFonts.inter(fontSize: 14),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
