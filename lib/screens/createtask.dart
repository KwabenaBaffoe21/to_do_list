import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/features/button.dart';
import 'package:to_do_list/screens/taskscreen.dart';

import '../features/input_field.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(
              0xff000000,
            ),
          ),
        ),
        title: Text(
          'ToDo List',
          style: GoogleFonts.courgette(
              fontSize: 32, fontWeight: FontWeight.normal),
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(43, 66, 43, 49),
            child: InputField(
              label: 'Task Name',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 43.0,right: 43,bottom: 70),
            child: InputField(
              label: 'Description',
              maxLength: 100,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 128.0,right: 127.0),
            child: Button(text: 'Done', screen: TaskScreen()),
          )
        ],
      ),
    );
  }
}
