import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/network/connection_checker.dart';
import 'package:task_wise/features/home/data/datasources/get_task_local_data_source.dart';
import 'package:task_wise/features/home/data/datasources/get_task_remote_data_source.dart';
import 'package:task_wise/features/home/domain/repository/get_task_repository.dart';

class GetTaskRepositoryImpl implements GetTaskRepository {
  final GetTaskRemoteDataSource remoteDataSource;
  final GetTasksLocalDataSource tasksLocalDataSource;
  final ConnectionChecker connectionChecker;

  GetTaskRepositoryImpl({
    required this.remoteDataSource,
    required this.tasksLocalDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<Task>>> getTasks(
    String status, {
    required String userId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        final tasks = tasksLocalDataSource.getTasks();
        return right(tasks);
      }
      final tasks = await remoteDataSource.getTasks(status, userId: userId);
      tasksLocalDataSource.uploadTask(tasks: tasks);
      return right(tasks);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncTask({required String userId}) async {
    try {
      final offlineTasks = tasksLocalDataSource.getOfflineTasks();
      if (offlineTasks.isEmpty) {
        return right(null);
      }
      await remoteDataSource.syncTasks(
        userId: userId,
        offlineTasks: offlineTasks,
      );
      tasksLocalDataSource.deleteOfflineTasks();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
