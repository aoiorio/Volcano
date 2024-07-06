// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/domain/entity/todo.dart';
import 'package:volcano/domain/repository/todo.dart';
import 'package:volcano/domain/usecase/todo.dart';

class TodoUseCaseImpl implements TodoUseCase {
  TodoUseCaseImpl({required TodoRepository todoRepository})
      : _todoRepository = todoRepository;
  final TodoRepository _todoRepository;

  @override
  Future<Either<BackEndError, Todo>> executePostTodo({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
    required File audio,
  }) {
    final todo = _todoRepository.postTodo(
      token: token,
      title: title,
      description: description,
      type: type,
      period: period,
      priority: priority,
      audio: audio,
    );
    return todo;
  }

  @override
  Future<Either<BackEndError, Todo>> executeTextToTodo({
    required String voiceText,
  }) {
    return _todoRepository.textToTodo(voiceText: voiceText);
  }

  @override
  Future<Either<BackEndError, Todo>> executePostTodoFromText({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
  }) {
    final todo = _todoRepository.postTodoFromText(
      token: token,
      title: title,
      description: description,
      type: type,
      period: period,
      priority: priority,
    );
    return todo;
  }

  @override
  Future<Either<BackEndError, List<ReadTodo>>> executeReadTodo({
    required String token,
  }) {
    final todos = _todoRepository.readTodo(token: token);
    return todos;
  }
}
