part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

final class AddNewTask extends TaskEvent {
  final String title;
  final String description;
  final String status;
  final String hexColor;
  final DateTime dueAt;
  final String userId;

  AddNewTask({
    required this.title,
    required this.description,
    required this.status,
    required this.hexColor,
    required this.dueAt,
    required this.userId,
  });
}

final class GetTasks extends TaskEvent {
  final String userId;

  GetTasks({required this.userId});
}
