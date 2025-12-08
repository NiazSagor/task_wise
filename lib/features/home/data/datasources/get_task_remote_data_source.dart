import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class GetTaskRemoteDataSource {
  Future<List<TaskModel>> getTasks(String status, {required String userId});

  Future<void> syncTasks({
    required String userId,
    required List<TaskModel> offlineTasks,
  });
}

class GetTaskSupabaseDataSource implements GetTaskRemoteDataSource {
  final SupabaseClient client;

  GetTaskSupabaseDataSource({required this.client});

  @override
  Future<List<TaskModel>> getTasks(
    String status, {
    required String userId,
  }) async {
    try {
      final response = await client
          .from("tasks")
          .select()
          .eq("user_id", userId);
      return response.map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> syncTasks({
    required String userId,
    required List<TaskModel> offlineTasks,
  }) async {
    try {
      for (var task in offlineTasks) {
        await client.from("tasks").insert({
          "title": task.title,
          "description": task.description,
          "dueAt": task.dueAt.toIso8601String(),
          "created_at": task.createdAt.toIso8601String(),
          "hexColor": task.hexColor,
          "user_id": userId,
        }).select();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
