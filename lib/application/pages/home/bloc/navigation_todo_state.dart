part of 'navigation_todo_cubit.dart';

@immutable
class NavigationTodoState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondaryBodyDisplayed;

  const NavigationTodoState(
      {this.selectedCollectionId, this.isSecondaryBodyDisplayed});
  @override
  List<Object?> get props => [isSecondaryBodyDisplayed, selectedCollectionId];
}

// class NavigationTodoStateLoading extends NavigationTodoState {}
