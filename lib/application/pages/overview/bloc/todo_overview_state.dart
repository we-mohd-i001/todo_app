part of 'todo_overview_cubit.dart';

class TodoOverviewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoOverviewInitial extends TodoOverviewState {}

class TodoOverviewStateLoading extends TodoOverviewState {}

class TodoOverviewStateLoaded extends TodoOverviewState {
  final List<TodoCollection> collections;
  TodoOverviewStateLoaded({required this.collections});
  @override
  List<Object?> get props => [collections];
}

class TodoOverviewStateError extends TodoOverviewState {}
