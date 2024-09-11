import 'package:cloud_firestore/cloud_firestore.dart';

void updateTask(
    {required String taskName,
    required String description,
    required String taskID}) {
  FirebaseFirestore.instance.collection('task').doc(taskID).update({
    'taskName': taskName,
    'description': description,
    'createdAt': DateTime.now()
  });
}
