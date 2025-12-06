import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class TaskRemoteDataSource {
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String status,
  });

  Future<void> updateTask({required String id, required String status});

  Future<void> deleteTask({required String id});

  Future<List<TaskModel>> getTasks({required String status});
}

class TaskRemoteDatSourceImpl implements TaskRemoteDataSource {
  final Dio client;

  TaskRemoteDatSourceImpl({required this.client});

  @override
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String status,
  }) async {
    try {
      final response = await client.post(
        "/createTask",
        data: {"title": title, "description": description, "status": status},
      );
      return TaskModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(e.response!.data["message"]);
      }
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTask({required String id}) async {
    try {
      await client.get("/deleteTask/$id");
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(e.response!.data["message"]);
      }
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TaskModel>> getTasks({required String status}) async {
    try {
      final response = await client.get("/listTaskByStatus/$status");
      final decodedJson =
          jsonDecode(response.data.toString()) as Map<String, dynamic>;
      final dataList = decodedJson['data'] as List<dynamic>;
      final List<TaskModel> tasks = dataList
          .map(
            (taskJson) => TaskModel.fromJson(taskJson as Map<String, dynamic>),
          )
          .toList();
      return tasks;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(e.response!.data["message"]);
      }
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateTask({required String id, required String status}) async {
    try {
      await client.get("/updateTaskStatus/$id/$status");
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(e.response!.data["message"]);
      }
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
