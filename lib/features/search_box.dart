import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/screens/search_page.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchPage(),
        ),
      ),
      readOnly: true,
      cursorHeight: 25,
      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle:
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: const BorderSide(
            color: Color(0xff65558f),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
