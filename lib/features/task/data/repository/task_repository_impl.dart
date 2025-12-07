import 'package:fpdart/fpdart.dart' hide Task;
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/core/constants/constants.dart';
import 'package:task_wise/core/error/failures.dart';
import 'package:task_wise/core/network/connection_checker.dart';
import 'package:task_wise/features/task/data/datasources/task_local_data_source.dart';
import 'package:task_wise/features/task/data/datasources/task_remote_data_source.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  final TaskLocalDataSource localDataSource;
  final ConnectionChecker connectionChecker;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Task>> createTask({
    required String title,
    required String description,
    required String status,
    required String hexColo,
    required DateTime dueAt,
    required String userId,
  }) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final task = await remoteDataSource.createTask(
        title: title,
        description: description,
        status: status,
        hexColo: hexColo,
        dueAt: dueAt,
        userId: userId,
      );
      localDataSource.createTask(task: task.toJson());
      return right(task);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask({required String id}) async {
    try {
      await remoteDataSource.deleteTask(id: id);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask({
    required String id,
    required String status,
  }) async {
    try {
      await remoteDataSource.updateTask(id: id, status: status);
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
