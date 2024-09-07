import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/task_filter.dart';
import '../features/search_box.dart';
import '../functions/task_item.dart';
import 'create_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All';
  String searchQuery = '';

  void onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  // Method to return a Firestore stream based on the selected filter
  Stream<QuerySnapshot<Map<String, dynamic>>> getTaskStream() {
    final taskCollection = FirebaseFirestore.instance.collection('task');

    Query<Map<String, dynamic>> query = taskCollection;

    if (selectedFilter == 'Completed') {
      query = query.where('status', isEqualTo: 'completed');
    } else if (selectedFilter == 'Incomplete') {
      query = query.where('status', isEqualTo: 'pending');
    }

    if (searchQuery.isNotEmpty) {
      query = query
          .where('title', isGreaterThanOrEqualTo: searchQuery)
          .where('title', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }

    return query.snapshots();
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
            child: SearchBox(
              onSearchChanged: onSearchChanged,
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
                          "Finally, We're done 🥳",
                          style: GoogleFonts.inter(
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
