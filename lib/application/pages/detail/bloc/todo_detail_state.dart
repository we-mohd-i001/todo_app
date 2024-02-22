part of 'todo_detail_cubit.dart';

class TodoDetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TodoDetailStateLoading extends TodoDetailState {}

class TodoDetailStateLoaded extends TodoDetailState {
  final List<EntryId> entryIds;

  TodoDetailStateLoaded({required this.entryIds});

  @override
  // TODO: implement props
  List<Object?> get props => [entryIds];
}

class TodoDetailStateError extends TodoDetailState {}
