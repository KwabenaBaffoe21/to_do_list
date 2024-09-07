import 'package:cloud_firestore/cloud_firestore.dart';

void addTask(
    {required String taskName, description, String status = 'pending'}) async {
  /*if (kDebugMode) {
    print('I AM WORKING');
  }*/
  FirebaseFirestore.instance.collection('task').add({
    'taskName': taskName,
    'description': description ?? '',
    'status': status,
    'createdAt': DateTime.now()
  });
 /* if (kDebugMode) {
    print(taskName);
    print(description);
  }*/
}
