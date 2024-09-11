import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/button.dart';
import 'create_task.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            'todo list'.toUpperCase(),
            style: GoogleFonts.courgette(
                fontSize: 32, fontWeight: FontWeight.normal),
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
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: const Color(0xff65558f),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 109.5),
            child: Button(
              text: 'New Task',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTask(),
                  ),
                );
              },
              icon: Icons.add,
            ),
          )
        ],
      ),
    );
  }
}
