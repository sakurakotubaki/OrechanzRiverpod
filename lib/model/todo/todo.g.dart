// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      task: json['task'] as String? ?? '',
      count: json['count'] as int? ?? 0,
      isDone: json['isDone'] as bool,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'task': instance.task,
      'count': instance.count,
      'isDone': instance.isDone,
    };
