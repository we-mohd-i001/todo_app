// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoEntryModel _$TodoEntryModelFromJson(Map<String, dynamic> json) =>
    TodoEntryModel(
      id: json['id'] as String,
      isDone: json['isDone'] as bool,
      description: json['description'] as String,
    );

Map<String, dynamic> _$TodoEntryModelToJson(TodoEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isDone': instance.isDone,
      'description': instance.description,
    };
