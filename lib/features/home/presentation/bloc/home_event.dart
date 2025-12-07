part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class GetTasks extends HomeEvent {
  final String userId;

  GetTasks({required this.userId});
}
