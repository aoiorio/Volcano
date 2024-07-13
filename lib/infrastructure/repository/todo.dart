import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/goal_percentage.dart';
import 'package:volcano/domain/entity/todo.dart';
import 'package:volcano/domain/repository/todo.dart';
import 'package:volcano/infrastructure/datasource/todo/todo_data_source.dart';
import 'package:volcano/infrastructure/dto/read_todo.dart';
import 'package:volcano/infrastructure/dto/todo.dart';
import 'package:volcano/infrastructure/model/todo/post_todo_model.dart';
import 'package:volcano/infrastructure/model/todo/update_todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoDataSource client}) : _client = client;
  final TodoDataSource _client;

  @override
  Future<Either<BackEndError, TodoDTO>> deleteTodo({required String todoId}) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<BackEndError, List<ReadTodoDTO>>> readTodo({
    required String token,
  }) async {
    try {
      final res = await _client.readTodo(token).then((value) {
        if (value[0].values != null) {
          debugPrint(value[0].values![0].title);
        }
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }

  @override
  Future<Either<BackEndError, TodoDTO>> textToTodo({
    required String voiceText,
  }) async {
    try {
      final res = await _client.textToTodo(voiceText).then((value) {
        debugPrint(value.period.toString());
        debugPrint(value.title.toString());
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }

  // TODO!!! the arguments are here
  @override
  Future<Either<BackEndError, String>> updateTodo({
    required String todoId,
    required String title,
    required String description,
    required DateTime period,
    required int priority,
    required String type,
    required String audioUrl,
    required bool isCompleted,
  }) async {
    try {
      final res = await _client
          .updateTodo(
        todoId,
        UpdateTodoModel(
          title: title,
          description: description,
          period: period,
          priority: priority,
          type: type,
          isCompleted: isCompleted,
          audioUrl: audioUrl,
        ),
      )
          .then((value) {
        debugPrint(value.response.statusCode.toString());
        return 'Updated';
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(e.toString());
      debugPrint(res.toString());
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }

  @override
  Future<Either<BackEndError, TodoDTO>> postTodo({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
    required File audio,
  }) async {
    try {
      final res = await _client
          .postTodo(token, title, description, period, type, priority, audio)
          .then((value) {
        debugPrint(value.audioUrl.toString());
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(e.toString());
      debugPrint(res.toString());
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }

  @override
  Future<Either<BackEndError, Todo>> postTodoFromText({
    required String token,
    required String title,
    required String? description,
    required String type,
    required DateTime period,
    required int priority,
  }) async {
    try {
      final res = await _client
          .postTodoFromText(
        token,
        PostTodoModel(
          title: title,
          description: description,
          type: type,
          period: period,
          priority: priority,
        ),
      )
          .then((value) {
        debugPrint(value.audioUrl.toString());
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(e.toString());
      debugPrint(res.toString());
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }

  @override
  Future<Either<BackEndError, GoalPercentage>> getGoalPercentage({
    required String token,
  }) async {
    try {
      final res = await _client.getGoalPercentage(token).then((value) {
        debugPrint(value.todayGoalPercentage.toString());
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(e.toString());
      debugPrint(res.toString());
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(
            res?.data ?? {'detail': 'Something went wrong'},
          ),
        ),
      );
    }
  }
}
