// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/goal_percentage.dart';
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

  @override
  Future<Either<BackEndError, GoalPercentage>> executeGetGoalPercentage({
    required String token,
  }) {
    final goalPercentage = _todoRepository.getGoalPercentage(token: token);
    return goalPercentage;
  }

  @override
  Future<Either<BackEndError, String>> executeUpdateTodo({
    required String todoId,
    required String title,
    required String description,
    required DateTime period,
    required int priority,
    required String type,
    required String audioUrl,
    required bool isCompleted,
  }) {
    final result = _todoRepository.updateTodo(
      todoId: todoId,
      title: title,
      description: description,
      period: period,
      priority: priority,
      type: type,
      audioUrl: audioUrl,
      isCompleted: isCompleted,
    );
    return result;
  }
}
