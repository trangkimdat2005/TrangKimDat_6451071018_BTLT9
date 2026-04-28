import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe/cau1/data/models/task_model.dart';

class TaskService {
  final CollectionReference _tasksCollection = FirebaseFirestore.instance.collection('tasks');

  Stream<List<TaskModel>> getTasks() {
    return _tasksCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addTask(String title) async {
    await _tasksCollection.add({
      'title': title,
      'isDone': false,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> toggleTask(String id, bool isDone) async {
    await _tasksCollection.doc(id).update({'isDone': isDone});
  }

  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }
}
