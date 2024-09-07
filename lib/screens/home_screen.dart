import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/functions/task_item.dart';
import 'package:to_do_list/screens/createtask.dart';

import '../features/task_filter.dart';
import '../features/search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('task').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const Image(
                      image: Svg('Images/Done.svg'),
                      width: 250,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Done!!\nYou have complete all task.',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23.0),
                      child: SearchBox(),
                    );
                  } else if (index == 1) {
                    return const TaskFilter();
                  } else {
                    final doc = snapshot.data!.docs[index - 2];

                    return TaskItem(doc: doc);
                  }
                },
                separatorBuilder: (context, index) {
                  if (index == 0 || index == 1) {
                    return const SizedBox.shrink();
                  } else {
                    return const Divider();
                  }
                },
                itemCount: snapshot.data!.docs.length + 2);
          }),
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
