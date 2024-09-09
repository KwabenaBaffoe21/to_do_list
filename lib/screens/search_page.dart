import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.onSearchChanged});

  final Function(String)? onSearchChanged;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 23.0),
          child: Text(
            'ToDo List',
            style: GoogleFonts.courgette(
                fontSize: 32, fontWeight: FontWeight.normal),
          ),
        ),
        leadingWidth: 154,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: TextField(
              controller: searchController,
              onChanged: widget.onSearchChanged,
              cursorHeight: 25,
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xff655587),
                ),
                suffixIcon: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                suffixIconColor: const Color(0xff65558f),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xff65558f),
                  ),
                  borderRadius: BorderRadius.circular(99),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(99),
                  borderSide: const BorderSide(
                    color: Color(0xff65558f),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
