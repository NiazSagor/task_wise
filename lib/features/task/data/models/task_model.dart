import 'package:task_wise/features/task/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.title,
    required super.description,
    required super.status,
    required super.createdAt,
    required super.id,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return TaskModel(
      title: data['title'] as String,
      description: data['description'] as String,
      status: data['status'] as String,
      id: data['_id'] as String,
      createdAt: data['createdDate'] as String,
    );
  }
}
