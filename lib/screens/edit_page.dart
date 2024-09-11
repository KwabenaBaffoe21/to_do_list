import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/features/button.dart';
import 'package:to_do_list/features/input_field.dart';
import 'package:to_do_list/functions/update.dart';
import 'package:to_do_list/screens/home_screen.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.taskID});

  final String taskID;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController taskNameController;
  late TextEditingController descriptionController;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff65558f),
          ),
        ),
        title: Text(
          'ToDo List',
          style: GoogleFonts.courgette(
              fontSize: 32, fontWeight: FontWeight.normal),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('task')
              .doc(widget.taskID)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Text(
                'Document not found',
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.normal),
              );
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            taskNameController.text = data['taskName'] ?? '';
            descriptionController.text = data['description'];

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  InputField(
                      label: 'Task Name', controller: taskNameController),
                  const SizedBox(height: 49.0),
                  InputField(
                      label: 'Description', controller: descriptionController),
                  const SizedBox(height: 70.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 127.5,right: 127.5),
                    child: Button(
                      text: 'Done',
                      onPressed: () {
                        updateTask(
                            taskName: taskNameController.text.trim(),
                            description: descriptionController.text.trim(),
                            taskID: widget.taskID);
                        final snackBar = SnackBar(
                          content: Text(
                            'Task Updated',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          duration: const Duration(microseconds: 500),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
