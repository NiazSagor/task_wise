import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/features/task/domain/entities/task.dart';

abstract interface class TaskRepository {
  Future<Either<Failure, Task>> createTask({
    required String title,
    required String description,
    required String status,
  });

  Future<Either<Failure, void>> updateTask({
    required String id,
    required String status,
  });

  Future<Either<Failure, void>> deleteTask({required String id});

  Future<Either<Failure, List<Task>>> getTasks({required String status});
}
