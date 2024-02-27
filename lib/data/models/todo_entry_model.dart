import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_entry_model.g.dart';


@JsonSerializable()
class TodoEntryModel extends Equatable {
  final String id;
  final bool isDone;
  final String description;

  const TodoEntryModel(
      {required this.id, required this.isDone, required this.description});

  factory TodoEntryModel.fromJson(Map<String, dynamic> json) =>
      _$TodoEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoEntryModelToJson(this);

  @override
  List<Object?> get props => [id, isDone, description];
}
