import 'package:hive/hive.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<void> createTask({required TaskModel task});

  Future<void> tempTask({required TaskModel task});

  Future<void> updateTask({required String id, required String status});

  Future<void> deleteTask({required String id});
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box allTaskBox;
  final Box offlineTaskBox;

  TaskLocalDataSourceImpl({
    required this.allTaskBox,
    required this.offlineTaskBox,
  });

  @override
  Future<void> createTask({required TaskModel task}) async {
    final json = task.toJson();
    allTaskBox.write(() {
      allTaskBox.put(json["id"], json);
    });
  }

  @override
  Future<void> deleteTask({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask({required String id, required String status}) {
    throw UnimplementedError();
  }

  @override
  Future<void> tempTask({required TaskModel task}) async {
    final json = task.toJson();
    offlineTaskBox.write(() {
      offlineTaskBox.put(json["id"], json);
    });
  }
}
