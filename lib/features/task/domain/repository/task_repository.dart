import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/core/error/failures.dart';

abstract interface class TaskRepository {
  Future<Either<Failure, Task>> createTask({
    required String title,
    required String description,
    required String status,
    required String hexColo,
    required DateTime dueAt,
    required String userId,
  });

  Future<Either<Failure, void>> updateTask({
    required String id,
    required String status,
  });

  Future<Either<Failure, void>> deleteTask({required String id});
}
