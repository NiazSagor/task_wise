import 'package:hive/hive.dart';

abstract interface class TaskLocalDataSource {
  Future<void> createTask({required Map<String, dynamic> task});

  Future<void> updateTask({required String id, required String status});

  Future<void> deleteTask({required String id});
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final Box box;

  TaskLocalDataSourceImpl({required this.box});

  @override
  Future<void> createTask({required Map<String, dynamic> task}) async {
    box.write(() {
      box.put(task["id"], task);
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
}
