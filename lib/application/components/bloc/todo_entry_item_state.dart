part of 'todo_entry_item_cubit.dart';

abstract class TodoEntryItemState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TodoEntryItemStateLoading extends TodoEntryItemState {}

class TodoEntryItemStateLoaded extends TodoEntryItemState {
  final TodoEntry todoEntry;
  TodoEntryItemStateLoaded({required this.todoEntry});
  @override
  List<Object?> get props => [todoEntry];
}

class TodoEntryItemStateError extends TodoEntryItemState {}
