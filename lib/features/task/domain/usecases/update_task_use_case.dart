import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';

class UpdateTaskUseCase implements UseCase<void, UpdateTaskParams> {
  final TaskRepository taskRepository;

  UpdateTaskUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, void>> call(UpdateTaskParams params) async {
    return await taskRepository.updateTask(
      id: params.id,
      status: params.status,
    );
  }
}

class UpdateTaskParams {
  final String id;
  final String status;

  UpdateTaskParams(this.id, this.status);
}
