import 'package:task_wise/features/task/domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required super.title,
    required super.description,
    required super.status,
    required super.createdAt,
    required super.id,
    required super.hexColor,
    required super.dueAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      status: json['status'] ?? "",
      id: json['id'] ?? "",
      hexColor: json['hexColor'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      dueAt: DateTime.parse(json['dueAt']),
    );
  }
}
