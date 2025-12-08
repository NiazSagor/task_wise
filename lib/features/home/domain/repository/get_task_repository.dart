import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/core/error/failures.dart';

abstract interface class GetTaskRepository {
  Future<Either<Failure, List<Task>>> getTasks(
    String status, {
    required String userId,
  });

  Future<Either<Failure, void>> syncTask({required String userId});
}
