import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_wise/core/common/entities/task.dart';
import 'package:task_wise/features/home/domain/usecases/get_tasks_use_case.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTasksUseCase _getTasksUseCase;

  HomeBloc({required GetTasksUseCase getTasksUseCase})
    : _getTasksUseCase = getTasksUseCase,
      super(HomeInitial()) {
    on<HomeEvent>((event, emit) => emit(HomeLoading()));
    on<GetTasks>(_getTasks);
  }

  void _getTasks(GetTasks event, Emitter<HomeState> emit) async {
    final result = await _getTasksUseCase(
      GetTasksParams(status: "", userId: event.userId),
    );

    result.fold(
      (failure) => emit(HomeFailure(message: failure.message)),
      (tasks) => emit(HomeSuccess(tasks: tasks)),
    );
  }
}
