part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<Task> tasks;

  HomeSuccess({required this.tasks});
}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});
}
