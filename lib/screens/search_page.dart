import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  List allResults = [];
  List resultList = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(onSearchChanged);
  }

  onSearchChanged() {
    print(searchController.text);
    searchResultList();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchController.removeListener(onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getClientStream();
  }

  searchResultList() {
    var showResults = [];
    if (searchController.text.isNotEmpty) {
      for (var taskSnapshot in allResults) {
        var name = taskSnapshot['taskName'].toString().toLowerCase();
        if (name.contains(
          searchController.text.toLowerCase(),
        )) {
          showResults.add(taskSnapshot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }
    setState(() {
      resultList = showResults;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('task')
        .orderBy('taskName_lowercase')
        .get();

    setState(() {
      allResults = data.docs;
    });
    searchResultList();
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
            child: CupertinoSearchTextField(
              controller: searchController,
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                itemBuilder: (context, index) {
                  final doc = resultList[index];
                  Timestamp timeStamp = doc['createdAt'];
                  DateTime dateTime = timeStamp.toDate();
                  String createdAt = DateFormat('HH:mm').format(dateTime);
                  return ListTile(
                    title: Text(
                      doc['taskName'],
                      style: GoogleFonts.poppins(),
                    ),
                    subtitle: Text(
                      doc['description'],
                      style: GoogleFonts.poppins(),
                    ),
                    trailing: Text(
                      createdAt,
                      style: GoogleFonts.poppins(),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: resultList.length),
          ),
        ],
      ),
    );
  }
}
