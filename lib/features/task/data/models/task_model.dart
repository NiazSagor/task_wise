import 'package:task_wise/core/common/entities/task.dart';

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
      id: json['id'].toString(),
      hexColor: json['hexColor'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      dueAt: DateTime.parse(json['dueAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "status": status,
      "created_at": createdAt.toIso8601String(),
      "hexColor": hexColor,
      "dueAt": dueAt.toIso8601String(),
    };
  }
}
