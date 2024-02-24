import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/core/form_value.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

part 'create_todo_entry_page_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageState> {
  CreateTodoEntryPageCubit({required this.collectionId})
      : super(const CreateTodoEntryPageState());

  final CollectionId collectionId;
  // final CreateTodoEntry addTodoEntry;
  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }
    emit(
      state.copyWith(
        description:
        FormValue(value: description, validationStatus: currentStatus),
      ),
    );
  }

  void submit() {}
}
