import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/usecase/usecase.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';

class DeleteTaskUseCase implements UseCase<void, DeleteTaskParams> {
  final TaskRepository taskRepository;

  DeleteTaskUseCase({required this.taskRepository});

  @override
  Future<Either<Failure, void>> call(DeleteTaskParams params) async {
    return await taskRepository.deleteTask(id: params.id);
  }
}

class DeleteTaskParams {
  final String id;

  DeleteTaskParams(this.id);
}
