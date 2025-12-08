import 'package:hive/hive.dart';
import 'package:task_wise/features/task/data/models/task_model.dart';

abstract interface class GetTasksLocalDataSource {
  void uploadTask({required List<TaskModel> tasks});

  List<TaskModel> getTasks();

  List<TaskModel> getOfflineTasks();

  void deleteOfflineTasks();
}

class GetTasksLocalDataSourceImpl implements GetTasksLocalDataSource {
  final Box allTaskBox;
  final Box offlineTaskBox;

  GetTasksLocalDataSourceImpl({
    required this.allTaskBox,
    required this.offlineTaskBox,
  });

  @override
  List<TaskModel> getTasks() {
    final List<TaskModel> tasks = [];
    for (var key in allTaskBox.keys) {
      tasks.add(TaskModel.fromJson(allTaskBox.get(key)));
    }
    return tasks;
  }

  @override
  void uploadTask({required List<TaskModel> tasks}) {
    allTaskBox.clear();
    allTaskBox.write(() {
      for (var e in tasks) {
        allTaskBox.put(e.id, e.toJson());
      }
    });
  }

  @override
  List<TaskModel> getOfflineTasks() {
    final List<TaskModel> tasks = [];
    for (var key in offlineTaskBox.keys) {
      tasks.add(TaskModel.fromJson(offlineTaskBox.get(key)));
    }
    return tasks;
  }

  @override
  void deleteOfflineTasks() {
    offlineTaskBox.clear();
  }
}
