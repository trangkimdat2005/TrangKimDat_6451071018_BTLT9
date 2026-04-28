import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final bool isDone;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  factory TaskModel.fromFirestore(String id, Map<String, dynamic> data) {
    DateTime parsedDate;
    final raw = data['createdAt'];
    if (raw is Timestamp) {
      parsedDate = raw.toDate();
    } else if (raw is DateTime) {
      parsedDate = raw;
    } else {
      parsedDate = DateTime.now();
    }

    return TaskModel(
      id: id,
      title: (data['title'] ?? data['name'] ?? '').toString(),
      isDone: data['isDone'] ?? data['done'] ?? false,
      createdAt: parsedDate,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'isDone': isDone,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  TaskModel copyWith({String? id, String? title, bool? isDone, DateTime? createdAt}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
