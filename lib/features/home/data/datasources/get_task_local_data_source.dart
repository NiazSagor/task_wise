import 'package:hive/hive.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class GetTasksLocalDataSource {
  void uploadTask({required List<TaskModel> tasks});

  List<TaskModel> getTasks();
}

class GetTasksLocalDataSourceImpl implements GetTasksLocalDataSource {
  final Box box;

  GetTasksLocalDataSourceImpl({required this.box});

  @override
  List<TaskModel> getTasks() {
    final List<TaskModel> tasks = [];
    for (var key in box.keys) {
      tasks.add(TaskModel.fromJson(box.get(key)));
    }
    return tasks;
  }

  @override
  void uploadTask({required List<TaskModel> tasks}) {
    box.clear();
    box.write(() {
      for (var e in tasks) {
        box.put(e.id, e.toJson());
      }
    });
  }
}
