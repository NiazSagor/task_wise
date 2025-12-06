import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/task/domain/entities/task.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';

class GetTasksUseCase implements UseCase<List<Task>, GetTasksParams> {
  final TaskRepository taskRepository;

  GetTasksUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, List<Task>>> call(GetTasksParams params) async {
    return await taskRepository.getTasks(status: params.status);
  }
}

class GetTasksParams {
  final String status;

  GetTasksParams(this.status);
}
