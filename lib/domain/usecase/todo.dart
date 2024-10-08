import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/read_todo.dart';
import 'package:volcano/domain/entity/todo.dart';
import 'package:volcano/infrastructure/dto/goal_info.dart';

abstract class TodoUseCase {
  Future<Either<BackEndError, Todo>> executeTextToTodo({
    required String voiceText,
  });

  Future<Either<BackEndError, Todo>> executePostTodo({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
    required File audio,
  });

  Future<Either<BackEndError, Todo>> executePostTodoFromText({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
  });

  Future<Either<BackEndError, List<ReadTodo>>> executeReadTodo({
    required String token,
  });

  Future<Either<BackEndError, String>> executeUpdateTodo({
    required String todoId,
    required String title,
    required String description,
    required DateTime period,
    required int priority,
    required String type,
    required String audioUrl,
    required bool isCompleted,
  });

  Future<Either<BackEndError, String>> executeDeleteTodo({
    required String todoId,
  });

  Future<Either<BackEndError, GoalInfo>> executeGetGoalInfo({
    required String token,
  });
}
