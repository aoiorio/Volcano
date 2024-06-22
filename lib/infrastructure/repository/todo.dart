import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:volcano/core/errors.dart';
import 'package:volcano/domain/entity/todo.dart';
import 'package:volcano/domain/repository/todo.dart';
import 'package:volcano/infrastructure/datasource/todo/todo_data_source.dart';
import 'package:volcano/infrastructure/dto/todo.dart';

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({required TodoDataSource client}) : _client = client;
  final TodoDataSource _client;

  @override
  Future<Either<BackEndError, TodoDTO>> deleteTodo({required String todoId}) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<BackEndError, List<TodoDTO>>> readTodo({
    required String userId,
  }) {
    // TODO: implement readTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<BackEndError, TodoDTO>> textToTodo({
    required String voiceText,
  }) async {
    try {
      final res = await _client.textToTodo(voiceText).then((value) {
        debugPrint(value.period.toString());
        return value;
      });
      return Either.right(res);
    } on DioException catch (e) {
      final res = e.response;
      debugPrint(res?.statusCode.toString());
      return Either.left(
        BackEndError(
          statusCode: res?.statusCode,
          message: BackEndErrorMessage.fromJson(res?.data),
        ),
      );
    }
  }

  @override
  Future<Either<BackEndError, TodoDTO>> updateTodo({required Todo todo}) {
    // TODO: implement updateTodo
    throw UnimplementedError();
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
          message: BackEndErrorMessage.fromJson(res?.data),
        ),
      );
    }
  }
}
