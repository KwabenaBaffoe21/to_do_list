import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/features/button.dart';
import 'package:to_do_list/screens/home_screen.dart';

import '../features/input_field.dart';
import '../functions/add_task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late TextEditingController taskNameController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

   @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
    descriptionController.dispose();
  }

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(43, 66, 43, 49),
              child: InputField(
                label: 'Task Name',
                controller: taskNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 43.0, right: 43, bottom: 70),
              child: InputField(
                label: 'Description',
                maxLength: 100,
                maxLines: 3,
                controller: descriptionController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 128.0, right: 127.0),
              child: Button(
                  text: 'Done',
                  onPressed: () {
                    addTask(
                      taskName: taskNameController.text.trim(),
                      description: descriptionController.text.trim(),
                    );

                    final snackBar = SnackBar(
                      content: Center(
                        child: Text(
                          'Task Set',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                      duration: const Duration(microseconds: 5),
                      backgroundColor: const Color(0xa6655587),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      width: 150,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
