import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/features/home/data/datasources/get_task_remote_data_source.dart';
import 'package:task_wise/features/home/domain/repository/get_task_repository.dart';
import 'package:task_wise/core/common/entities/task.dart';

class GetTaskRepositoryImpl implements GetTaskRepository {
  final GetTaskRemoteDataSource remoteDataSource;

  GetTaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Task>>> getTasks(
    String status, {
    required String userId,
  }) async {
    try {
      final tasks = await remoteDataSource.getTasks(status, userId: userId);
      return right(tasks);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
