import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/task/domain/entities/task.dart';
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
    );
  }
}

class AddTaskParams {
  final String title;
  final String description;
  final String status;

  AddTaskParams(this.title, this.description, this.status);
}
