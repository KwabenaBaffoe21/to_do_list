import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/task_filter.dart';
import '../features/task_item.dart';
import 'create_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';
  List allResults = [];
  List resultList = [];

  @override
  void initState() {
    super.initState();
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

  void onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  // Method to return a Firestore stream based on the selected filter
  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskStream() {
    final taskCollection = FirebaseFirestore.instance.collection('task');

    if (selectedFilter == 'All') {
      return taskCollection.snapshots();
    } else if (selectedFilter == 'Completed') {
      return taskCollection.where('status', isEqualTo: 'completed').snapshots();
    } else {
      return taskCollection.where('status', isEqualTo: 'pending').snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            'ToDo List',
            style: GoogleFonts.courgette(
                fontSize: 32, fontWeight: FontWeight.w500),
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
          TaskFilter(
            onFilterChanged: onFilterChanged, // Pass filter change callback
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getTaskStream(),
              // Use the dynamic query based on the filter
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: Svg('Images/NoTasks.svg'),
                          width: 250,
                          height: 200,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'No New Task',
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff65558f)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    return TaskItem(doc: doc);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.docs.length,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateTask(),
          ),
        ),
        backgroundColor: const Color(0xff65558f),
        shape: const CircleBorder(eccentricity: 1),
        child: const Icon(
          Icons.add,
          color: Color(0xffffffff),
          size: 55,
        ),
      ),
    );
  }
}
