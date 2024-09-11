import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getTaskID(String taskName) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('task')
      .where('taskName', isEqualTo: taskName)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first.id;
  } else {
    throw Exception('Document not found');
  }
}
