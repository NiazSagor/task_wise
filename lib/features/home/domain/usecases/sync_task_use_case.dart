import 'package:fpdart/fpdart.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/home/domain/repository/get_task_repository.dart';

class SyncTasksUseCase implements UseCase<void, SyncTasksParams> {
  final GetTaskRepository taskRepository;

  SyncTasksUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, void>> call(SyncTasksParams params) async {
    return await taskRepository.syncTask(userId: params.userId);
  }
}

class SyncTasksParams {
  final String userId;

  SyncTasksParams({required this.userId});
}
