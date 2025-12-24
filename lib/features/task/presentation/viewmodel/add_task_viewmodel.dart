import 'package:flutter/foundation.dart';
import 'package:task_wise/features/task/domain/repository/task_repository.dart';

class AddTaskViewModel extends ChangeNotifier {
  final TaskRepository repository;

  AddTaskViewModel({required this.repository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    _setLoading(true);
    _errorMessage = null;
    _isSuccess = false;

    final result = await repository.createTask(
      title: title,
      description: description,
      userId: "",
      status: "",
      hexColo: "",
      dueAt: DateTime.now(),
    );

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isSuccess = false;
      },
      (success) {
        _isSuccess = true;
        _errorMessage = null;
      },
    );

    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void resetState() {
    _isLoading = false;
    _errorMessage = null;
    _isSuccess = false;
  }
}
