import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'filter_button.dart';

class TaskFilter extends StatefulWidget {
  const TaskFilter({
    super.key,
  });

  @override
  State<TaskFilter> createState() => _TaskFilterState();
}

class _TaskFilterState extends State<TaskFilter> {
  String selectedFilter = 'All';
  late Future<List<DocumentSnapshot>> documentsFuture;

  @override
  void initState(){
    super.initState();
    documentsFuture=fetchDocuments();
  }

  Future<List<DocumentSnapshot>> fetchDocuments() async {
    QuerySnapshot snapshot;

    if (selectedFilter == 'All') {
      snapshot=await FirebaseFirestore.instance.collection('task').get();
    } else if (selectedFilter == 'Completed') {
      snapshot = await FirebaseFirestore.instance
          .collection('task')
          .where('status', isEqualTo: 'completed')
          .get();
    } else{
     snapshot= await FirebaseFirestore.instance
          .collection('task')
          .where('status', isEqualTo: 'pending')
          .get();
    }
   return snapshot.docs;
  }

  void onFilterSelected(String filter) {
   setState(() {
     selectedFilter = filter;
     documentsFuture = fetchDocuments();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 35,
        ),
        FilterButton(
          label: 'All',
          isSelected: selectedFilter == 'All',
          onSelected: () => onFilterSelected('All'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FilterButton(
            label: 'Completed',
            isSelected: selectedFilter == 'Completed',
            onSelected: () => onFilterSelected('Completed')
          ),
        ),
        FilterButton(
          label: 'Incomplete',
          isSelected: selectedFilter == 'Incomplete',
          onSelected: () => onFilterSelected('Incomplete'),
        ),
      ],
    );

  }
}
