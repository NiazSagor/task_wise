import 'package:dio/dio.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class GetTaskRemoteDataSource {
  Future<List<TaskModel>> getTasks(String status, {required String userId});

  Future<void> syncTasks({
    required String userId,
    required List<TaskModel> offlineTasks,
  });
}

class GetTaskDataSourceImpl implements GetTaskRemoteDataSource {
  final Dio client;

  GetTaskDataSourceImpl({required this.client});

  @override
  Future<List<TaskModel>> getTasks(
    String status, {
    required String userId,
  }) async {
    try {
      final response = await client.get("/listTaskByStatus/$status");

      if (response.data["status"] != "success") {
        throw ServerException("Task was not created");
      }
      List rawList = response.data['data'];
      return rawList.map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> syncTasks({
    required String userId,
    required List<TaskModel> offlineTasks,
  }) {
    throw UnimplementedError();
  }
}
