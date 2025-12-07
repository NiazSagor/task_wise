part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskFailure extends TaskState {
  final String message;

  TaskFailure({required this.message});
}

final class TasksDisplaySuccess extends TaskState {
  final List<Task> tasks;

  TasksDisplaySuccess({required this.tasks});
}

final class TaskLoading extends TaskState {}

final class AddNewTaskSuccess extends TaskState {
  final Task task;

  AddNewTaskSuccess({required this.task});
}
