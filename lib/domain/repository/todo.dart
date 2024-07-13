import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/goal_percentage.dart';
import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/domain/entity/todo.dart';

// NOTE I think that I can change arguments to model
abstract class TodoRepository {
  Future<Either<BackEndError, Todo>> textToTodo({required String voiceText});

  Future<Either<BackEndError, Todo>> postTodo({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
    required File audio,
  });

  Future<Either<BackEndError, Todo>> postTodoFromText({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
  });

  // TODO add todo_id as required
  Future<Either<BackEndError, String>> updateTodo({
    required String todoId,
    required String title,
    required String description,
    required DateTime period,
    required int priority,
    required String type,
    required String audioUrl,
    required bool isCompleted,
  });

  Future<Either<BackEndError, Todo>> deleteTodo({required String todoId});

  Future<Either<BackEndError, List<ReadTodo>>> readTodo({
    required String token,
  });

  Future<Either<BackEndError, GoalPercentage>> getGoalPercentage({
    required String token,
  });
}
