import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/features/home/domain/usecases/get_tasks_use_case.dart';
import 'package:task_wise/features/task/domain/usecases/add_task_use_case.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase _addTaskUseCase;

  TaskBloc({
    required AddTaskUseCase addTaskUseCase,
    required GetTasksUseCase getTasksUseCase,
  }) : _addTaskUseCase = addTaskUseCase,
       super(TaskInitial()) {
    on<TaskEvent>((event, emit) => emit(TaskLoading()));
    on<AddNewTask>(_addNewTask);
  }

  void _addNewTask(AddNewTask event, Emitter<TaskState> emit) async {
    final result = await _addTaskUseCase(
      AddTaskParams(
        title: event.title,
        description: event.description,
        status: event.status,
        hexColor: event.hexColor,
        dueAt: event.dueAt,
        userId: event.userId,
      ),
    );
    result.fold(
      (failure) => emit(TaskFailure(message: failure.message)),
      (task) => emit(AddNewTaskSuccess(task: task)),
    );
  }
}
