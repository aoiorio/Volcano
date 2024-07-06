import 'package:volcano/infrastructure/dto/todo.dart';

class ReadTodo {
  ReadTodo({
    this.type,
    this.values,
  });

  final String? type;
  final List<TodoDTO>? values;
}
