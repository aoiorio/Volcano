import 'dart:convert';

import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/infrastructure/dto/todo.dart';

class ReadTodoDTO extends ReadTodo {
  ReadTodoDTO({
    super.type,
    super.values,
  });

  factory ReadTodoDTO.fromJson(Map<String, dynamic> json) => ReadTodoDTO(
        type: json['type'],
        values: json['values'] == null
            ? []
            : List<TodoDTO>.from(
                // ignore: avoid_dynamic_calls, inference_failure_on_untyped_parameter, unnecessary_lambdas
                json['values']!.map((x) => TodoDTO.fromJson(x)),
              ),
      );

  factory ReadTodoDTO.fromRawJson(String str) =>
      ReadTodoDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'type': type,
        'values': values == null
            ? <dynamic>[]
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}
