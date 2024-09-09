import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;
  String searchQuery = '';

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

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getTaskStream() {
    final taskCollection = FirebaseFirestore.instance.collection('task');

    if(searchQuery.isEmpty){
      return null;
    }

    Query<Map<String, dynamic>> query = taskCollection;

    if (searchQuery.isNotEmpty) {
      query = query
          .where('title_lowercase', isGreaterThanOrEqualTo: searchQuery)
          .where('title_lowercase', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }
    return query.snapshots();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
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
          Expanded(
            child: StreamBuilder(
                stream: getTaskStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Task doesn't exist",
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff65558f),
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.separated(
                      padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                      itemBuilder: (context, index) {
                        final doc = snapshot.data!.docs[index];
                        Timestamp timeStamp = doc['createdAt'];
                        DateTime dateTime = timeStamp.toDate();
                        String createdAt = DateFormat('HH:mm').format(dateTime);
                        return ListTile(
                          title: Text(
                            doc['taskName'],
                            style: GoogleFonts.inter(),
                          ),
                          subtitle: Text(
                            doc['description'],
                            style: GoogleFonts.inter(),
                          ),
                          trailing: Text(
                            createdAt,
                            style: GoogleFonts.inter(),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data!.docs.length);
                }),
          ),
        ],
      ),
    );
  }
}
