import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';

class AddTaskUseCase implements UseCase<Task, AddTaskParams> {
  final TaskRepository taskRepository;

  AddTaskUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, Task>> call(AddTaskParams params) async {
    return await taskRepository.createTask(
      title: params.title,
      description: params.description,
      status: params.status,
      hexColo: params.hexColor,
      dueAt: params.dueAt,
      userId: params.userId,
    );
  }
}

class AddTaskParams {
  final String title;
  final String description;
  final String status;
  final String hexColor;
  final DateTime dueAt;
  final String userId;

  AddTaskParams({
    required this.title,
    required this.description,
    required this.status,
    required this.hexColor,
    required this.dueAt,
    required this.userId,
  });
}
