import 'package:flutter/foundation.dart';
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/features/home/domain/repository/get_task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final GetTaskRepository repository;

  TaskViewModel({required this.repository}) {
    fetchTasks("new", userId: "");
  }

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> fetchTasks(String status, {required String userId}) async {
    _setLoading(true);
    _errorMessage = null;

    final result = await repository.getTasks(status, userId: userId);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _tasks = [];
      },
      (taskList) {
        _tasks = taskList;
        _errorMessage = null;
      },
    );

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
