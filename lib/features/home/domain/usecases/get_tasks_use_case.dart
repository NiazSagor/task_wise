import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/home/domain/repository/get_task_repository.dart';
import 'package:task_wise/core/common/entities/task.dart';

class GetTasksUseCase implements UseCase<List<Task>, GetTasksParams> {
  final GetTaskRepository taskRepository;

  GetTasksUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, List<Task>>> call(GetTasksParams params) async {
    return await taskRepository.getTasks(params.status, userId: params.userId);
  }
}

class GetTasksParams {
  final String userId;
  final String status;

  GetTasksParams({required this.status, required this.userId});
}
