import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/screens/createtask.dart';

import '../features/filter.dart';
import '../features/search_box.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23),
            child: SearchBox(),
          ),
          SizedBox(
            height: 25,
          ),
          Filter()
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
