import 'dart:convert';

import 'package:volcano/domain/entity/todo.dart';

class TodoDTO extends Todo {
  TodoDTO({
    super.id,
    super.todoId,
    super.title,
    super.description,
    super.period,
    super.priority,
    super.type,
    super.userId,
    super.audioUrl,
    super.isCompleted,
    super.createdAt,
    super.updatedAt,
  });

  factory TodoDTO.fromJson(Map<String, dynamic> json) => TodoDTO(
        id: json['id'],
        todoId: json['todo_id'],
        title: json['title'],
        description: json['description'],
        period: json['period'] == null ? null : DateTime.parse(json['period']),
        priority: json['priority'],
        type: json['type'],
        userId: json['user_id'],
        audioUrl: json['audio_url'],
        isCompleted: json['is_completed'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at']),
      );

  factory TodoDTO.fromRawJson(String str) => TodoDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'todo_id': todoId,
        'title': title,
        'description': description,
        'period': period?.toIso8601String(),
        'priority': priority,
        'type': type,
        'user_id': userId,
        'audio_url': audioUrl,
        'is_completed': isCompleted,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
