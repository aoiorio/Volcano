import 'package:flutter/material.dart';
import 'package:volcano/domain/entity/todo.dart';
import 'package:volcano/infrastructure/dto/todo.dart';

class TodoDetailsRouteModel {

  TodoDetailsRouteModel({
    this.key,
    required this.typeName,
    required this.userTodo,
  });

  final Key? key;
  final String typeName;
  final List<TodoDTO> userTodo;
}
