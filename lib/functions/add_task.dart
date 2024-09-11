import 'package:cloud_firestore/cloud_firestore.dart';

void addTask(
    {required String taskName, description, String status = 'pending'}) async {
  FirebaseFirestore.instance.collection('task').add({
    'taskName': taskName,
    'taskName_lowercase': taskName.toLowerCase(),
    'description': description ?? '',
    'status': status,
    'createdAt': DateTime.now()
  });
}
