import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.doc});

  final QueryDocumentSnapshot doc;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.doc['status'] == 'completed';
  }

  @override
  Widget build(BuildContext context) {
    Timestamp timeStamp = widget.doc['createdAt'];
    DateTime dateTime = timeStamp.toDate();
    String createdAt = DateFormat('HH:mm').format(dateTime);
    return ListTile(
      leading: Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              String newStatus = isChecked ? 'completed' : 'pending';
              FirebaseFirestore.instance
                  .collection('task')
                  .doc(widget.doc.id)
                  .update({'status': newStatus});
            });
          }),
      title: Text(
        widget.doc['taskName'],
        style: GoogleFonts.inter(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        widget.doc['description'],
        style: GoogleFonts.inter(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Column(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actionsPadding: const EdgeInsets.all(20),
                        actions: [
                          TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('task')
                                  .doc(widget.doc.id)
                                  .delete();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red, fontSize: 25),
                            ),
                          ),
                          const TextButton(
                            onPressed: null,
                            child: Text(
                              'Edit',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.more_vert_rounded,
              ),
            ),
          ),
          Text(
            createdAt,
          ),
        ],
      ),
    );
  }
}
