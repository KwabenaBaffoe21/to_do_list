import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:to_do_list/screens/createtask.dart';

import 'features/button.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            'todo list'.toUpperCase(),
            style: GoogleFonts.courgette(fontSize: 32),
          ),
        ),
        leadingWidth: 154,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Image(
              image: Svg('Images/NoTasks.svg'),
              width: 350,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'No Task Yet',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: const Color(0xff65558f),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 109.5),
            child: Button(
              text: 'New Task',
              screen: CreateTask(),
              icon: Icons.add,
            ),
          )
        ],
      ),
    );
  }
}
