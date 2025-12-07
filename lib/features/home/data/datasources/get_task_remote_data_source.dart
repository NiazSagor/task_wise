import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_wise/core/error/exceptions.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class GetTaskRemoteDataSource {
  Future<List<TaskModel>> getTasks(String status, {required String userId});
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
}
