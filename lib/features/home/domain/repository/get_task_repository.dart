import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/common/entities/task.dart';

abstract interface class GetTaskRepository {
  Future<Either<Failure, List<Task>>> getTasks(
    String status, {
    required String userId,
  });
}
