import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wise/features/task/domain/entities/task.dart';
import 'package:task_wise/features/task/domain/usecases/add_task_use_case.dart';
import 'package:task_wise/features/task/domain/usecases/get_tasks_use_case.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase _addTaskUseCase;
  final GetTasksUseCase _getTasksUseCase;

  TaskBloc({
    required AddTaskUseCase addTaskUseCase,
    required GetTasksUseCase getTasksUseCase,
  }) : _getTasksUseCase = getTasksUseCase,
       _addTaskUseCase = addTaskUseCase,
       super(TaskInitial()) {
    on<TaskEvent>((event, emit) => emit(TaskLoading()));
    on<AddNewTask>(_addNewTask);
    on<GetTasks>(_getTasks);
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
      (failure) => emit(AddNewTaskFailure()),
      (task) => emit(AddNewTaskSuccess(task: task)),
    );
  }

  void _getTasks(GetTasks event, Emitter<TaskState> emit) async {
    final result = await _getTasksUseCase(
      GetTasksParams(status: "", userId: event.userId),
    );

    result.fold(
      (failure) => emit(TaskFailure(message: failure.message)),
      (tasks) => emit(TasksDisplaySuccess(tasks: tasks)),
    );
  }
}
