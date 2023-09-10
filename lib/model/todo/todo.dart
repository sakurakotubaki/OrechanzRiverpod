import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

// flutter pub run build_runner watch

@freezed
class Todo with _$Todo {
  const factory Todo({
    @Default('') String task,
    @Default(0) int count,
    required bool isDone,
  }) = _Todo;

  factory Todo.fromJson(Map<String, Object?> json)
      => _$TodoFromJson(json);
}